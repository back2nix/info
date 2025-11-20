```
sudo tc qdisc

sudo tc qdisc delete dev wlo1 root
sudo tc qdisc add dev wlo1 root netem delay 50ms 50ms loss 50% rate 50kbit
sudo tc qdisc add dev wlo1 root netem limit 12500 slot 75ms 200ms packets 1

sudo modprobe sch_netem

sudo tc qdisc delete dev eth0 root
sudo tc qdisc add dev eth0 root netem delay 50ms 50ms loss 50% rate 50kbit
```

- Посмотреть внешние соединения

sudo netstat -tupn

sudo ss -tulnp | grep ':8080'

ss -ntp state established 'dport = :5432'
```bash
Recv-Q Send-Q Local Address:Port  Peer Address:PortProcess
0      0              [::1]:45002        [::1]:5432
0      0              [::1]:55666        [::1]:5432
```

ss -s
```bash
Total: 1430
TCP:   243 (estab 55, closed 156, orphaned 3, timewait 76)

Transport Total     IP        IPv6
RAW       1         0         1
UDP       19        15        4
TCP       87        60        27
INET      107       75        32
FRAG      0         0         0
```
