$TTL 60
@   IN SOA ns1.example.spotify.cnamed.com. admin.example.spotify.cnamed.com. (
        2023010101 ; Serial
        7200       ; Refresh
        3600       ; Retry
        1209600    ; Expire
        60         ; Negative Cache TTL
)

@   IN NS  ns1.example.spotify.cnamed.com.
ns1 IN A   127.0.0.1

; Many SRV records, such that the UDP response gets truncated

@   IN SRV 10 10 5060 target001.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target002.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target003.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target004.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target005.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target006.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target007.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target008.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target009.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target010.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target011.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target012.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target013.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target014.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target015.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target016.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target017.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target018.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target019.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target020.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target021.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target022.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target023.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target024.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target025.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target026.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target027.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target028.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target029.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target030.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target031.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target032.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target033.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target034.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target035.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target036.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target037.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target038.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target039.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target040.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target041.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target042.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target043.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target044.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target045.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target046.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target047.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target048.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target049.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target050.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target051.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target052.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target053.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target054.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target055.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target056.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target057.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target058.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target059.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target060.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target061.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target062.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target063.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target064.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target065.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target066.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target067.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target068.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target069.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target070.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target071.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target072.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target073.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target074.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target075.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target076.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target077.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target078.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target079.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target080.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target081.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target082.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target083.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target084.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target085.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target086.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target087.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target088.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target089.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target090.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target091.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target092.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target093.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target094.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target095.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target096.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target097.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target098.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target099.example.spotify.cnamed.com.
@   IN SRV 10 10 5060 target100.example.spotify.cnamed.com.
