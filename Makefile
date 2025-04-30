# Upstream serves the large SRV record set and invoked by downstream
UPSTREAM_PORT := 9053
UPSTREAM_IP := 127.0.0.1
UPSTREAM_COREFILE := Corefile.upstream
UPSTREAM_ZONE_FILE := db.example.spotify.cnamed.com
UPSTREAM_PID_FILE := upstream.pid

# Downstream generates CNAME and triggers chase
DOWNSTREAM_PORT := 1053
DOWNSTREAM_IP := 127.0.0.1
DOWNSTREAM_COREFILE := Corefile.downstream
DOWNSTREAM_PID_FILE := downstream.pid

PID_FILES := $(UPSTREAM_PID_FILE) $(DOWNSTREAM_PID_FILE)

.PHONY: all start stop test

all: start test stop clean

start: start-upstream start-downstream
	@echo "Both CoreDNS instances started."
	@echo "Upstream (PID: $$(cat $(UPSTREAM_PID_FILE))) on $(UPSTREAM_IP):$(UPSTREAM_PORT) using $(UPSTREAM_COREFILE)"
	@echo "Downstream (PID: $$(cat $(DOWNSTREAM_PID_FILE))) on $(DOWNSTREAM_IP):$(DOWNSTREAM_PORT) using $(DOWNSTREAM_COREFILE)"

stop: stop-upstream stop-downstream
	@echo "Both CoreDNS instances stopped."

# Perform the test query against the downstream instance
test:
	@echo ">>> Performing test UDP query: dig @$(DOWNSTREAM_IP) -p $(DOWNSTREAM_PORT) SRV example.spotify.com."
	@dig @$(DOWNSTREAM_IP) -p $(DOWNSTREAM_PORT) SRV example.spotify.com.

# Clean up runtime files (PID files)
clean: stop
	@echo "Removing runtime files (PIDs)..."
	@rm -f $(PID_FILES)
	@echo "Cleanup complete."

start-upstream:
	@echo "Starting CoreDNS instance Upstream using $(UPSTREAM_COREFILE) on $(UPSTREAM_IP):$(UPSTREAM_PORT)..."
	@if ! test -f $(UPSTREAM_COREFILE); then echo "Error: $(UPSTREAM_COREFILE) not found."; exit 1; fi
	@coredns -conf $(UPSTREAM_COREFILE) -dns.port $(UPSTREAM_PORT) -pidfile $(UPSTREAM_PID_FILE) &
	@sleep 1
	@if ! test -f $(UPSTREAM_PID_FILE); then echo "Failed to start Upstream or create PID file."; exit 1; fi
	@echo "Upstream CoreDNS instance started."

start-downstream:
	@echo "Starting CoreDNS instance Downstream using $(DOWNSTREAM_COREFILE) on $(DOWNSTREAM_IP):$(DOWNSTREAM_PORT)..."
	@if ! test -f $(DOWNSTREAM_COREFILE); then echo "Error: $(DOWNSTREAM_COREFILE) not found."; exit 1; fi
	@coredns -conf $(DOWNSTREAM_COREFILE) -dns.port $(DOWNSTREAM_PORT) -pidfile $(DOWNSTREAM_PID_FILE) &
	@sleep 1
	@if ! test -f $(DOWNSTREAM_PID_FILE); then echo "Failed to start Downstream or create PID file."; exit 1; fi
	@echo "Downstream CoreDNS instance started."

stop-upstream:
	@if test -f $(UPSTREAM_PID_FILE); then \
		echo "Stopping CoreDNS instance Upstream (PID: $$(cat $(UPSTREAM_PID_FILE)))..."; \
		kill $$(cat $(UPSTREAM_PID_FILE)) || echo "Upstream already stopped."; \
		rm -f $(UPSTREAM_PID_FILE); \
	else \
		echo "Upstream PID file not found, assuming stopped."; \
	fi

stop-downstream:
	@if test -f $(DOWNSTREAM_PID_FILE); then \
		echo "Stopping CoreDNS instance Downstream (PID: $$(cat $(DOWNSTREAM_PID_FILE)))..."; \
		kill $$(cat $(DOWNSTREAM_PID_FILE)) || echo "Downstream already stopped."; \
		rm -f $(DOWNSTREAM_PID_FILE); \
	else \
		echo "Downstream PID file not found, assuming stopped."; \
	fi
