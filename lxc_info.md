####

- https://linuxcontainers.org/ru/lxc/getting-started/

```
sudo apt-get remove --auto-remove lxc
```

- https://ubuntu.com/server/docs/containers-lxc

```
sudo vim /usr/share/lxc/templates/lxc-download
```

```
sudo apt update
sudo apt install snapd
sudo snap install core
sudo snap refresh core --channel=latest/stable
sudo snap install lxd;
sudo snap refresh lxd --channel=latest/stable;
lxc -v;
lxd --verison;
sudo systemctl reload snap.lxd.daemon.service
sudo systemctl restart snap.lxd.daemon.service
lxd init
sudo lxc launch ubuntu:20.04 super-test;
sudo lxc start super-test
sudo lxc stop super-test;
sudo lxc exec super-test bash;

sudo lxc launch ubuntu:20.04 super-test1;
sudo lxc start super-test1
sudo lxc stop super-test1;
sudo lxc exec super-test1 bash;

lxc config set super-test1 security.nesting true
# для openvpn
lxc config set super-test1 security.privileged true
lxc restart super-test1
```

```
#lxc config edit super-test
# для docker
lxc config set super-test security.nesting true
# для openvpn
lxc config set super-test security.privileged true
lxc restart super-test
```

##### sudo nvim /etc/lxc/default.conf

```
lxc.cgroup.devices.allow = c 10:200 rwm
lxc.mount.entry = /dev/net/tun dev/net/tun none bind,create=file

lxc.cgroup.devices.allow = c 10:200 rwm
lxc.mount.entry = /dev/net /dev/net none bind,create=dir 0 0

lxc.mount.entry = /dev/net/tun dev/net/tun_fs none bind,create=file
lxc.cgroup.devices.allow = c 10:200 rwm
lxc.cap.keep  = CAP_MKNOD
lxc.cap.drop = mac_admin mac_override sys_time sys_module
```
