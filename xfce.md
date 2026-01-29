sudo apt install xfce4 xfce4-goodies -y

# Установка xrdp
sudo apt install xrdp -y

# Создание конфигурации для XFCE4
echo "xfce4-session" > ~/.xsession

# Настройка xrdp для использования XFCE4
sudo sed -i.bak '/fi/a #xrdp multiple users configuration \n xfce4-session \n' /etc/xrdp/startwm.sh

# Или альтернативный способ - отредактировать файл напрямую
sudo vim /etc/xrdp/startwm.sh
```
# Закомментируй существующие строки и добавь:
#test -x /etc/X11/Xsession && exec /etc/X11/Xsession
#exec /bin/sh /etc/X11/Xsession

# Добавь эти строки:
startxfce4
```

sudo adduser xrdp ssl-cert

# Перезапуск xrdp
sudo systemctl restart xrdp

# Включение автозапуска
sudo systemctl enable xrdp

# Проверка статуса
sudo systemctl status xrdp

vim /etc/xrdp/xrdp.ini
```
use_fastpath=both
bulk_compression=true
crypt_level=low

```

nix shell nixpkgs#freerdp -c xfreerdp /u:root /p:Iw5dsD64daOR7 /v:45.153.190.88:3389 /gfx /rfx /bpp:32 /network:lan

