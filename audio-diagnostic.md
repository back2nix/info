### 1. Статус PipeWire и WirePlumber
Эта команда покажет, видит ли звуковой сервер устройство ввода вообще и какой профиль выбран.
```bash
wpctl status
```

### 2. Проверка устройств на уровне ядра (ALSA)
Нужно понять, видит ли само ядро Linux микрофон (Capture device).
```bash
arecord -l
```

### 3. Логи ядра (поиск ошибок прошивки/драйвера)
Так как у тебя Lunar Lake, очень важно проверить, загрузилась ли прошивка SOF (Sound Open Firmware).
```bash
dmesg | grep -iE 'snd|sof|audio|hda|sound|wireplumber'
```

### 4. Информация об аудио-контроллере
```bash
lspci -nnk | grep -A3 Audio
```

### 5. Текущие настройки микшера
Иногда канал "Capture" просто выключен (muted) или стоит на 0 на аппаратном уровне.
```bash
amixer -c0 scontents
```
