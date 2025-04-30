# CoreDNS Issue: Truncated Response Handling with CNAME Rewrite and Cache Interaction

This repository provides a reproducible test case demonstrating an issue in CoreDNS involving CNAME chasing via the `rewrite` plugin, upstream UDP response truncation, and interaction with the `cache` plugin.

## Prerequisites

Ensure the `coredns` executable is present in your system's `PATH`. For macOS users, it can typically be installed via Homebrew: `brew install coredns`.

## Reproduction Steps

1.  **Start Services:** Execute `make start` to launch the two CoreDNS instances required for this test setup.:
2.  **Perform Test Query:** Run `make test` to execute a `dig` query against the downstream instance. This query triggers the CNAME chase and encounters the upstream truncation.
3.  **Stop Services & Clean Up:** Execute `make stop` to terminate the CoreDNS instances and remove temporary PID files.

## Test Setup Overview

This repository includes the minimal configuration necessary to observe the issue, consisting of two CoreDNS instances:

1.  **Downstream Instance (Entry Point):** This instance listens on port 1053. It's configured using `template` to respond to SRV queries for `example.spotify.com` with a CNAME record pointing to `example.spotify.cnamed.com.`. Crucially, it uses `rewrite cname suffix . .` to trigger an internal recursive lookup for this CNAME target and `forward` to direct this lookup to the upstream instance. It also utilizes the `cache` plugin.
2.  **Upstream Instance:** This instance listens on port 9053. It serves records for the zone `example.spotify.cnamed.com.` from a static zone file (`db.example.spotify.cnamed.com`). This zone file contains 100 SRV records, deliberately causing its response size to exceed standard UDP limits, resulting in a truncated (TC bit set) response over UDP.

## Issue Description: Observed vs. Expected Behavior

When a client queries the downstream instance for `SRV example.spotify.com.`, the following sequence occurs:

1.  The downstream instance generates the CNAME response.
2.  The `rewrite cname suffix . .` directive triggers an internal lookup for `SRV example.spotify.cnamed.com.`.
3.  This internal lookup is forwarded to the upstream instance.
4.  The upstream instance replies via UDP with a truncated response (TC bit set) because the full record set (100 SRV records) is too large.
5.  The downstream instance receives this truncated response.

**Expected Behavior:**

It was initially expected that the downstream instance's internal resolver mechanism (triggered by `rewrite` and handled by `forward`) would recognize the TC bit from the upstream UDP response and therefore require the client to retry via TCP to fetch the full response.

**Observed Behavior:**

The downstream instance receives the truncated UDP response from upstream. Due to the interaction between the `rewrite` and `cache` plugins, the **truncated result** appears to be cached. The downstream instance then synthesizes a response to the original client query (`SRV example.spotify.com.`). This synthesized response includes the CNAME record and *only the portion of the SRV records that fit in the truncated upstream UDP response* (e.g., records 1 through ~72). Because this combined response is still large (due to the CNAME + partial SRV list), the downstream instance correctly sets the TC bit in its response *to the client*.

The client, seeing the TC bit, retries the original query (`SRV example.spotify.com.`) to the downstream instance using TCP. However, this TCP query hits the cache in the downstream instance, which serves the previously stored **truncated** result. The client never receives the full list of 100 SRV records.

## Analysis

The core issue seems to stem from how the truncated upstream response is processed when both `rewrite cname suffix . .` (triggering internal recursion) and `cache` are active in the downstream instance.

1.  The `forward` plugin successfully receives the truncated UDP response from the upstream.
2.  However, when this result propagates back through the plugin chain (specifically interacting with `rewrite` handling the recursive result and then `cache`), the fact that the data is incomplete (truncated) is seemingly lost before caching occurs.
3.  The `cache` plugin stores the partial result set received via UDP from the upstream.
4.  The downstream server *does* correctly signal truncation *to the client* in its initial UDP response, primarily because the combined size (CNAME + partial SRV data) still exceeds UDP limits. (If the combined size were smaller, the client might incorrectly believe it received a complete response).
5.  The client's subsequent TCP retry only retrieves the incomplete data from the downstream cache.

The problem appears to be that the cache stores the truncated data instead of storing nothing (forcing a proper TCP fetch on cache miss). The `rewrite` plugin's handling of the recursive result might be interfering with the propagation of the truncation status to the `cache` plugin.
