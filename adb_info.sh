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

### Вытащить apk на комп
```bash
adb shell pm list packages | grep com.example.app
adb shell pm path com.example.app
adb pull /data/app/com.example.app-1.apk C:\путь\куда\сохранить\app.apk
```
- или

```bash
adb shell pm path com.example.app | sed 's/package://g' | xargs -I {} adb pull {} app.apk
```

Скриншот с экрана телефона и сразу в clipboard
```
adb exec-out screencap -p | xclip -selection clipboard -t image/png
```

```
adb shell dumpsys window | grep "mCurrentFocus"
adb shell uiautomator dump
adb pull /sdcard/window_dump.xml
```
