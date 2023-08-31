###

- https://grafana.com/grafana/download

```
sudo apt-get install -y adduser libfontconfig1
wget https://dl.grafana.com/enterprise/release/grafana-enterprise_8.1.3_amd64.deb
sudo dpkg -i grafana-enterprise_8.1.3_amd64.deb

sudo systemctl status grafana-server.service

http://localhost:3000/login
```
