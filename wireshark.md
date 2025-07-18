- https://www.youtube.com/@ChrisGreer/videos


```
http2
(http2)

clientHello
tls.handshake.type == 1

h/h2/h3
(http or http2 or http3) and (http.request.method in {"GET", "POST"} or http2.headers.method in {"GET", "POST"} or http3.headers.method in {"GET", "POST"} )

default
(http or http2 or http3 or quic)

dns/tls
dns.qry.name or tls.handshake.extensions_server_name

h1/h2/h3 withCode
(http or http2 or http3) and
(
    (http.request.method in {"GET", "POST"} or http2.headers.method in {"GET", "POST"} or http3.headers.method in {"GET", "POST"})
    or
    (http.response.code or http2.headers.status or http3.headers.status)
)
```


uri
```
tshark -r wireshark_dump/2_tiktok.pcapng -o tls.keylog_file:sslkeylog/2_sslkeylog.txt -Y "http2.headers.method" -T fields -e http2.headers.method -e http2.headers.authority -e http2.headers.path
```
