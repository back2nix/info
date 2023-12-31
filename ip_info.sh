# разрешить програаме работать через определенный интерфейс
https://unix.stackexchange.com/questions/210982/bind-unix-program-to-specific-network-interface

# metric приоритет
nmcli connection
sudo nmcli connection modify "Wired connection 1" ipv4.route-metric 102
nmcli connection up "Wired connection 1"

nmcli -t -f NAME,DEVICE con
route -n
sudo systemctl restart NetworkManager

# Отключить eth0 навсегда
# https://askubuntu.com/questions/427922/disable-network-permanently
sudo vim /etc/network/interfaces
iface eth0 inet manual

# ping через интерфейс
ping -c1 -I enp0s8 8.8.8.8

ip link | awk -F: '$0 !~ "lo|vir|wl|^[^0-9]"{print $2;getline}'

iw dev | awk '$1=="Interface"{print $2}'

# nmcli
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-configuring_ip_networking_with_nmcli

# найти сетевой интерфейс
lspci -vnnk | grep -i eth
lshw -C network

# network
/etc/init.d/networking restart

# socket: too many open files
ss -s
ss -t -a
ss -t -a | grep CLOSE-WAIT | wc -l
netstat -ao | grep 5000
netstat -ao | grep 7777 | wc -l

netstat -atunp 5000

lsof -i -a
ls /proc/7285/fd/

sudo systemclt stop daemon_remote_ssh_v2.service

sudo ping -s 1300 -f 192.168.88.1
ping size=1300 interval=0.1 79.174.188.193
# Светалан - омега интернет
89219313709

# check ip address
#
- https://webbrowsertools.com/ip-address/
- Чтобы не моглий определить мой настоящий proxy
- webrtc disable https://chrome.google.com/webstore/detail/webrtc-leak-shield/bppamachkoflopbagkdoflbgfjflfnfl/related
