### Utils

- https://www.youtube.com/watch?v=f9wIvrKSJkM

- Альтернатива wget, качает в несколько потоков
```
sudo apt install aria2
aria2c -x5 https://releases.ubuntu.com/22.04/ubuntu-22.04-desktop-amd64.iso?_ga=2.45151980.935491075.1654545331-461275318.1654545331
```

- find
```
find -iname "*.md" -ls
find -mmin -120 -iname "*.md" -ls
find -name "*.md" -delete

find Music/ -name *.mp3 -exec file {} \;
```
- lbzip2 |pv| lbzip2 -d
- sockat

- ssh ubuntu@site 'sudo tcpdump -i ens5 -U -w - not port 22' | sudo wireshark -k -i -

- От facebook очень быстро разжимает
- zstd
