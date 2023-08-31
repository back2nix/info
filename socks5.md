### Docker

```
sudo docker run --name socks5 -p "9999:1080" -e PROXY_USER=user -e PROXY_PASSWORD=password serjs/go-socks5-proxy
sudo docker run --name socks5 -p "9998:1080" serjs/go-socks5-proxy

ssh -D 1337 -f -C -N ubuntu@site -p 9998
```

#### Дополнительно

- https://gist.github.com/yougg/5d2b3353fc5e197a0917aae0b3287d64

```
sudo apt install dante-client

curl -x socks5://[user:password@]proxyhost[:port]/ url

export http_proxy=socks5h://login:password@11.11.11.11:9999
export {https,ftp,rsync,all}_proxy=$http_proxy

unset {http,https,ftp,rsync,all}_proxy {HTTP,HTTPS,FTP,RSYNC,ALL}_PROXY
```

### Не работает
SOCKS_USERNAME="REPO_DEPRECATED" SOCKS_PASSWORD="password" SOCKS_SERVER="11.11.11.11:9999" socksify curl ifconfig.me
