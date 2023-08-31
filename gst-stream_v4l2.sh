# rk3399
gst-launch-1.0 v4l2src device=/dev/video0 io-mode=4 ! videoconvert ! video/x-raw,format=NV12,width=640,height=480 ! kmssink
sudo v4l2-ctl --list-devices
v4l2-ctl --list-formats
v4l2-ctl -d /dev/video2 --list-formats-ext


# вывести дерево
lsusb -t
# посмотреть подробно
lsusb -s 01:5 -v

# для проверки вебкамер webcam - webcamoid
webcamoid-8.8.0-x86_64.AppImage

# Ссылки

- https://patrickelectric.work/blog/2018/streaming-with-gstreamer/

### компилятция по rk3399

- https://github.com/WainDing/mpp_linux_cpp

- https://github.com/rockchip-linux/gstreamer-rockchip
- Нужен последний mpp как написано в isusse:
- https://github.com/rockchip-linux/gstreamer-rockchip/issues/75
- https://github.com/rockchip-linux/mpp
- mpp нужно скомпилить
- cmake просит выставить переменные

```
export RKPLATFORM=RK3399
CMAKE_TOOLCHAIN_FILE=????
```

Передал файл https://github.com/rockchip-linux/mpp/tree/develop/build/linux/arm
CMAKE_TOOLCHAIN_FILE=arm.linux.cross.cmake

```
gst-launch-1.0 v4l2src device=/dev/video12 ! image/jpeg, width=1280, height=720, framerate=30/1 ! jpegparse ! mppjpegdec ! kmssink sync=false
gst-launch-1.0 v4l2src device=/dev/video12 ! image/jpeg, width=1920, height=1080, framerate=30/1 ! jpegparse ! mppjpegdec ! kmssink sync=false
gst-launch-1.0 v4l2src device=/dev/video12 ! image/jpeg, width=640, height=480, framerate=30/1 ! jpegparse ! mppjpegdec ! kmssink sync=false

gst-launch-1.0 v4l2src device=/dev/video1 ! image/jpeg, width=640, height=480, framerate=30/1 ! jpegparse ! jpegdec ! videoconvert ! xvimagesink

```

```
	gst-launch-1.0 rkisp num-buffers=20 device=/dev/video0 io-mode=1 ! \
	video/x-raw,format=NV12,width=1920,height=1080,framerate=10/1 ! jpegenc ! \
	multifilesink location=/home/orangepi/camera_capture_frame%d.jpg

    gst-launch-1.0 -v videotestsrc  ! "video/x-raw,width=1920,height=1080"  \
        ! queue ! jpegenc ! queue ! jpegparse ! queue ! mppvideodec ! rkximagesink
```


```
cp librkisp.so /opt/build/usr/lib  -a
cp libgstrkisp.so /opt/build/usr/lib/gstreamer-1.0/ -a
cp libgstvideo4linux2.so /opt/build/usr/lib/  -a
cp librkisp_aec.so /opt/build/usr/lib/rkisp/ae  -a
cp librkisp_af.so /opt/build/usr/lib/rkisp/af -a
cp librkisp_awb.so /opt/build/usr/lib/rkisp/awb -a
```

### nvidia

gst-launch-1.0 v4l2src device=/dev/video0 io-mode=2 ! image/jpeg, width=1280, height=720, framerate=30/1, format=MJPG ! nvjpegdec ! video/x-raw,format=I420,width=1280,height=720,framerate=30/1 ! videoconvert ! xvimagesink

v4l2src device=/dev/video0 io-mode=2 ! image/jpeg, width=1280, height=720, framerate=30/1, format=MJPG ! nvjpegdec ! video/x-raw,format=I420,width=1280,height=720,framerate=30/1 ! appsink
