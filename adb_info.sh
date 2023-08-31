sudo apt update
sudo apt install -y android-tools-adb android-tools-fastboot

adb kill-server
# посмотреть список устройств
adb devices
# отладка по сети
adb connect 192.168.0.100

# нажать на экран
adb shell input tap 1024 512 

# для eperia z5 выставить 4л принудительно
adb shell wm density %target dpi% ( для нашего разрешения по-моему 806)
