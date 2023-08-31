# сменить раскладку ubuntu

# https://www.youtube.com/watch?v=0qXIL8SdDZA&t=223s

atl+shit
sudo apt install gnome-tweaks
sudo apt install gnome-startup-applications

отключить Wayland

/etc/gdm3/custom.conf

WaylandEnable=false
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target #https://ostechnix.com/linux-tips-disable-suspend-and-hibernation/

```
sudo nano /etc/systemd/logind.conf
[Login]
HandleLidSwitch=ignore
HandleLidSwitchDocked=ignore

sudo systemctl reload systemd-logind.service
```

sudo gdm3 -reset # ???

#fn not work?
https://www.youtube.com/watch?v=gFvwL0hzEFg
esc + fn

# always on bottom

# https://askubuntu.com/questions/351720/how-to-start-an-application-with-bottom-most-property

sudo apt-get install devilspie4
vim ~/.config/devilspie2/chromium.lua

```bash
debug_print("Window Name: " .. get_window_name())
debug_print("Application name: " .. get_application_name())
debug_print("WM_CLASS: " .. get_class_instance_name())
debug_print("Window Class: " .. get_window_class())
if (string.match(get_application_name(),"Chrome$")) then
   set_window_below();
end
```

devilspie2 --debug

sudo systemctl restart gdm
gsettings reset org.gnome.mutter experimental-features
sudo apt install --reinstall ubuntu-gnome-desktop

sudo vim /etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nomodeset"
update-grub
sudo reboot

gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true
gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier '<Alt>'

# woe usb

https://www.how2shout.com/linux/how-to-install-woeusb-on-ubuntu-20-04-lts/

sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

# тестить камеры qtcam

sudo apt install -y qtcam
sudo apt install cheese

# upgrade ubuntu

https://linuxconfig.org/how-to-upgrade-ubuntu-to-20.10

```
sudo apt update
sudo apt upgrade
sudo apt dist-upgrade
```

#####

- sudo nvim /etc/update-manager/release-upgrades

```
# Default behavior for the release upgrader.

[DEFAULT]
# Default prompting behavior, valid options:
#
#  never  - Never check for a new release.
#  normal - Check to see if a new release is available.  If more than one new
#           release is found, the release upgrader will attempt to upgrade to
#           the release that immediately succeeds the currently-running
#           release.
#  lts    - Check to see if a new LTS release is available.  The upgrader
#           will attempt to upgrade to the first LTS release available after
#           the currently-running one.  Note that this option should not be
#           used if the currently-running release is not itself an LTS
#           release, since in that case the upgrader won't be able to
#           determine if a newer release is available.
Prompt=normal
```

```
sudo do-release-upgrade
```

#### Скачать пакет с зависимостями

```
sudo apt-get install --download-only gstreamer1.0-plugins-bad
# тут будут лежать пакеты
cd /var/cache/apt/archives
```

### disable enable console or gui ubuntu

```
# поставить 22.04
sudo dgpk-recongigure gdm3
sudo systemctl set-default multi-user
gnome-session-quit
```

```
sudo systemctl set-default graphical
startx
sudo systemctl start gdm3
```

### рисуем стрелочки на скриншотах

shutter

### switch keyboard languange

gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Alt>Shift_L']"
