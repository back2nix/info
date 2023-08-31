```
export DEST=OrangePiRK3399/output/rootfs

wget http://cdimage.ubuntu.com/ubuntu-base/releases/18.04/release/ubuntu-base-18.04.5-base-arm64.tar.gz

sudo mkdir $DEST
sudo tar xzvf ubuntu-base-18.04.5-base-arm64.tar.gz -C $DEST

sudo cp -av /usr/bin/qemu-aarch64-static $DEST/usr/bin
sudo cp -av /run/systemd/resolve/stub-resolv.conf $DEST/etc/resolv.conf

sudo mount --bind /dev $DEST/dev
sudo mount --bind /dev/pts $DEST/dev/pts || true
#sudo mount --bind /run $DEST/run || true

sudo chroot "$DEST" mount -t proc proc /proc || true
sudo chroot "$DEST" mount -t sysfs sys /sys || true

sudo chroot "$DEST"

apt install dialog perl

sudo umount -f $DEST/dev
#sudo mount -f $DEST/dev/pts || true
#sudo mount -f $DEST/run || true
```

- https://github.com/orangepi-xunlong/OrangePiRK3399_scripts/blob/b37576d004fa912402a4e0981bab6dc9c5722adc/lib/platform/rk3399.sh#L143
- https://github.com/orangepi-xunlong/OrangePiRK3399_external/tree/956689929b70f97ab343edf0681f45df0fbadfae/packages/source
