# Info
- https://forums.developer.nvidia.com/t/x-freezes-nvidia-gpu-0-wait/70356/3
sudo nvim /usr/share/X11/xorg.conf.d/10-nvidia.conf


```bash
Section "OutputClass"
    Identifier     "nvidia-prime"
    MatchDriver    "nvidia-drm"
    Driver         "nvidia"
    Option         "metamodes" "DVI-D-0: nvidia-auto-select +0+0 {ForceCompositionPipeline=On}"
    Option         "UseNvKmsCompositionPipeline" "false"
    Option         "PrimaryGPU" "true"
    Option         "AllowEmptyInitialConfiguration" "true"
    #Option         "AllowIndirectGLXProtocol" "off"
    #Option         "TripleBuffer" "on"
EndSection
```

orig

```bash
Section "OutputClass"
    Identifier "nvidia"
    MatchDriver "nvidia-drm"
    Driver "nvidia"
    Option "AllowEmptyInitialConfiguration"
    ModulePath "/usr/lib/x86_64-linux-gnu/nvidia/xorg"
EndSection
```

# выставить максимльную производительность

- https://rastating.github.io/how-to-permanently-set-nvidia-powermizer-settings-in-ubuntu/

```bash
nvidia-settings -a "[gpu:0]/GpuPowerMizerMode=1"
nvidia-settings -q GpuPowerMizerMode
```

ubuntu-drivers devices

#### troubleshooting

https://wiki.archlinux.org/index.php/NVIDIA/Troubleshooting

# регулировка скорости fan speed nvidia linux
sudo vim /usr/share/X11/xorg.conf.d/10-nvidia.conf

```bash
Section "OutputClass"
    Identifier "nvidia"
    MatchDriver "nvidia-drm"
    Driver "nvidia"
    Option "AllowEmptyInitialConfiguration"
    Option "Coolbits" "28"
    ModulePath "/usr/lib/x86_64-linux-gnu/nvidia/xorg"
EndSection
```

nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan:0]/GPUTargetFanSpeed=90" --  :1 -once
nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan:1]/GPUTargetFanSpeed=90" --  :1 -once

nvidia-settings -a "[gpu:2]/GPUFanControlState=1" -a "[fan:0]/GPUTargetFanSpeed=90" --  :1 -once
nvidia-settings -a "[gpu:2]/GPUFanControlState=1" -a "[fan:1]/GPUTargetFanSpeed=90" --  :1 -once

# выключить
nvidia-settings -a "[gpu:0]/GPUFanControlState=0" -- :0 -once

И делаем logout

# xorg nvidia fucking nvidia
https://wiki.archlinux.org/index.php/NVIDIA_Optimus#GDM

# hiveos nvidia

```bash
modprobe nvidia_drm modeset=1
nvidia-persistenced --persistence-mode
```

```bash
# /hive/etc/edid.bin
sudo nvidia-xconfig \
       --enable-all-gpus \
       --cool-bits=31 \
       --connected-monitor="DFP-0" \
       --custom-edid="DFP-0:/home/ed/edid.bin" \
       --preserve-driver-name
```

## Отключение libglamoregl.so

```bash
# disable glamregl extension as it often crashes X server
[[ -f /usr/lib/xorg/modules/libglamoregl.so ]] &&
        mv -f /usr/lib/xorg/modules/libglamoregl.so /usr/lib/xorg/modules/libglamoregl.so.disabled
[[ -f /opt/amdgpu/lib/xorg/modules/libglamoregl.so ]] &&
        mv -f /opt/amdgpu/lib/xorg/modules/libglamoregl.so /opt/amdgpu/lib/xorg/modules/libglamoregl.so.disabled
```


### install driver version
wget https://us.download.nvidia.com/XFree86/Linux-x86_64/455.45.01/NVIDIA-Linux-x86_64-455.45.01.run
sudo chomod +x NVIDIA-Linux-x86_64-455.45.01.run
sudo ./NVIDIA-Linux-x86_64-455.45.01.run

### cuda 11.2
wget https://developer.download.nvidia.com/compute/cuda/11.2.1/local_installers/cuda_11.2.1_460.32.03_linux.run
sudo sh cuda_11.2.1_460.32.03_linux.run


#### Hardware acelerete HW engine

- https://docs.nvidia.com/jetson/l4t/index.html#page/Tegra%20Linux%20Driver%20Package%20Development%20Guide/accelerated_gstreamer.html#wwpID0E0520HA

```

#gst-launch-1.0 filesrc location=example.mp4 ! \
#  qtdemux name=demux demux.video_0 ! queue ! h264parse ! omxh264dec ! \
#  nveglglessink -e



# Работает на ogate v8
gst-launch-1.0 filesrc location=example.mp4 ! \
  qtdemux name=demux demux.video_0 ! queue ! h264parse ! omxh264dec ! \
  nveglglessink -e

# Работает на ogate v8
gst-launch-1.0 filesrc location=example.mp4 ! \
  qtdemux ! queue ! h264parse ! nvv4l2decoder ! nv3dsink -e

# Рабочая
gst-launch-1.0 -v v4l2src device=/dev/video0 ! jpegdec ! video/x-raw,framerate=30/1,width=1280,height=800 ! videoconvert ! xvimagesink

gst-launch-1.0 -v v4l2src device=/dev/video0 ! nvjpegdec ! video/x-raw,framerate=30/1,width=1280,height=800 ! videoconvert ! xvimagesink

gst-launch-1.0 videotestsrc ! 'video/x-raw, format=(string)I420, width=(int)640, height=(int)480' ! omxh264enc ! 'video/x-h264, streamformat=(string)byte-stream' ! h264parse ! qtmux ! filesink location=test.mp4 -e

# Рабочая и enc и dec
gst-launch-1.0 videotestsrc ! 'video/x-raw, format=(string)I420, width=(int)640, height=(int)480' ! omxh264enc ! 'video/x-h264, streamformat=(string)byte-stream' ! h264parse ! nvv4l2decoder ! nv3dsink -e

#gst-launch-1.0 v4l2src device=/dev/video0 ! 'video/x-h264, streamformat=(string)byte-stream' ! h264parse ! nvv4l2decoder ! nv3dsink -e

# розовый экран
gst-launch-1.0 v4l2src device=/dev/video0 ! "image/jpeg,framerate=30/1,width=1280,height=720" ! jpegparse ! nvjpegdec ! video/x-raw ! nvvidconv ! 'video/x-raw(memory:NVMM)' ! nvoverlaysink


#gst-launch-1.0 v4l2src device=/dev/video0 ! "image/jpeg,framerate=30/1,width=1280,height=720" ! jpegparse ! nvjpegdec ! video/x-raw,framerate=30/1,width=1280,height=800 ! videoconvert ! xvimagesink

??? sudo apt-get install gstreamer1.0-plugins-bad
```

####

- https://forums.developer.nvidia.com/t/how-to-hardware-accelerate-mjpeg-decoding-of-frames-from-webcam-using-gst/82820
- https://elinux.org/Jetson/L4T/r32.2.x_patches

#### Проблемы с установкой nvidia

```
sudo vim /etc/modprobe.d/blacklist-nouveau.conf
```

###### /etc/modprobe.d/blacklist-nouveau.conf
```
blacklist nouveau
options nouveau modeset=0
```

```
sudo update-initramfs -u
sudo reboot
```

# Nvlink show nvlink
nvidia-smi topo --matrix

### docker nvidia

- https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker

### Очиста диска

- https://github.com/NVIDIA-AI-IOT/jetson-min-disk
- https://nvidia-ai-iot.github.io/jetson-min-disk/

- table compare
- https://docs.google.com/spreadsheets/d/1DOHMLQnt9FT0gclPGLKaaSSBQkXT8yOe/edit#gid=1187446092
