# снять прошивку
sudo dd if=/dev/sdb of=backup.img  bs=4M status=progress

# Залить обратно
sudo dd if=backup.img of=/dev/sdb bs=4M status=progress
sudo dd if=opay_2021.27.04.img of=/dev/sdb bs=4M status=progress

# считать mbr
dd if=/dev/sda of=mbr.img bs=512 count=1
# восстановить mbr
dd if=mbr.img of=/dev/sda

#resize2fs -M xxx.img

https://github.com/econsysqtcam/qtcam/blob/master/INSTALL
4.1.3 Ubuntu 18.04
```bash
sudo apt install dirmngr
sudo apt-add-repository ppa:qtcam/bionic
sudo apt-get update
sudo apt-get install qtcam
```

xzcat Armbian_21.02.3_Orangepi4_focal_current_5.10.21.img.xz | dd of=/dev/sdb bs=4M status=progress conv=sync
sync

sudo apt install guvcview

sudo dd if=OrangePi_4_debian_stretch_desktop_linux4.4.179_v1.4.img of=/dev/sdb bs=4M status=progress conv=sync
sudo dd if=TwisterOSArmbianV2-0-1.img of=/dev/sdb bs=4M status=progress conv=sync

# shrink
# https://superuser.com/questions/610819/how-to-resize-img-file-created-with-dd
#sudo losetup -f --partscan opay_2021.15.03_shrink.img
sudo losetup --partscan /dev/loop1 opay_2021.15.03_shrink.img
lsblk
sudo gparted /dev/loop1
fdisk /dev/loop1
# enter p
sudo dd if=/dev/loop1 of=opay_2021.15.03_shrink.img bs=512 count=39462912 status=progress
sudo losetup -d loop0

cat /sys/devices/virtual/thermal/thermal_zone1/temp

```
sudo dd if=opay_pi4b.img of=/dev/sdb conv=sync,noerror bs=1M status=progress &&  sync
```

```
cat /sys/devices/virtual/thermal/thermal_zone0/temp
```

#####

```
truncate --size=18G opay_2021.31.08.img
```

### Настройка дисплея

- https://wiki.radxa.com/Rockpi4/hardware/display

### fix export DISPLAY=:0

```
sudo cat /var/run/lightdm/root/:0 > ~/.Xauthority
```

#### disable black screen

```
export DISPLAY=:0.0
xset s off
xset s noblank
xset -dpms
```

#### gst-streamer rk3399 hardware acceleration

```
gst-launch-1.0 v4l2src device=/dev/video12 ! image/jpeg, width=1280, height=720, framerate=30/1 ! jpegparse ! mppjpegdec ! kmssink sync=false
gst-launch-1.0 v4l2src device=/dev/video12 ! image/jpeg, width=1920, height=1080, framerate=30/1 ! jpegparse ! mppjpegdec ! kmssink sync=false
gst-launch-1.0 v4l2src device=/dev/video12 ! image/jpeg, width=640, height=480, framerate=30/1 ! jpegparse ! mppjpegdec ! kmssink sync=false
```

gst-launch-1.0 v4l2src device=/dev/video10 ! image/jpeg, width=1920, height=1080, framerate=30/1 ! jpegparse ! mppjpegdec ! kmssink sync=false
