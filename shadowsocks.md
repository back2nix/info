### Server
- https://losst.pro/nastrojka-shadowsocks
- for android
- https://play.google.com/store/search?q=Shadowsocks&c=apps&hl=ru&gl=US
- algos
- https://github.com/teddysun/shadowsocks_install/blob/master/shadowsocks-all.sh
- geoip us
- https://pq.hosting/vps-vds-usa-new-jersey-secaucus


```bash
apt update
apt install -y shadowsocks-libev

/etc/shadowsocks-libev
```

```/etc/shadowsocks-libev/config.json
{
    "server":["::1", "?.?.?.?"],
    "mode":"tcp_and_udp",
    "server_port":8388,
    "local_port":1080,
    "password":"???????",
    "timeout":60,
    "method":"rc4-md5"
}
```

```bash
systemctl restart shadowsocks-libev
wget -qO- eth0.me
```

### Client

```bash
/usr/bin/ss-server -c /etc/shadowsocks-libev/config.json
```
