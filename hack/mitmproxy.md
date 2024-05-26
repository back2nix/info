
Чтобы настроить MITM Proxy в прозрачном режиме и минимизировать возможность его обнаружения сервером, следуйте этим шагам:

### Шаг 1: Установите MITM Proxy
Установите MITM Proxy с помощью pip:
```sh
pip install mitmproxy
```

### Шаг 2: Настройте Transparent Proxy

- https://docs.mitmproxy.org/stable/howto-transparent/

Создайте правила iptables для перенаправления трафика на MITM Proxy:

```sh
# Enable IP forwarding.
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv6.conf.all.forwarding=1
# Disable ICMP redirects.
sysctl -w net.ipv4.conf.all.send_redirects=0
```

```sh
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 443 -j REDIRECT --to-port 8080
sudo ip6tables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080
sudo ip6tables -t nat -A PREROUTING -i eth0 -p tcp --dport 443 -j REDIRECT --to-port 8080
```
Эти правила перенаправят весь входящий HTTP и HTTPS трафик на порт 8080, где будет работать MITM Proxy.

### Шаг 3: Запустите MITM Proxy
Запустите MITM Proxy в прозрачном режиме:
```sh
mitmproxy --mode transparent --showhost
```
Опция `--mode transparent` включает прозрачный режим, а `--showhost` отображает значение заголовка Host в URL.

### Шаг 4: Установите корневой сертификат
Откройте браузер на клиентском устройстве и перейдите на [mitm.it](http://mitm.it), чтобы установить корневой сертификат MITM Proxy. Это необходимо для перехвата и расшифровки HTTPS трафика.

### Шаг 5: Настройте устройство клиента
Настройте клиентское устройство так, чтобы оно использовало ваш MITM Proxy в качестве шлюза по умолчанию. Это можно сделать вручную или через DHCP-сервер, который автоматически раздаст настройки прокси.

### Дополнительные меры для минимизации обнаружения
1. **Удаление заголовков прокси**: Используйте скрипты для удаления заголовков `Via` и `X-Forwarded-For` из запросов и ответов.
2. **Проверка времени отклика**: Минимизируйте задержки, чтобы серверы не заметили аномально долгое время отклика.
3. **Туннелирование через VPN**: Используйте VPN, чтобы скрыть использование MITM Proxy.

Пример скрипта для удаления заголовков:

```python
from mitmproxy import http

def request(flow: http.HTTPFlow) -> None:
    if "Via" in flow.request.headers:
        del flow.request.headers["Via"]
    if "X-Forwarded-For" in flow.request.headers:
        del flow.request.headers["X-Forwarded-For"]

def response(flow: http.HTTPFlow) -> None:
    if "Via" in flow.response.headers:
        del flow.response.headers["Via"]
```

Запустите MITM Proxy с использованием этого скрипта:
```sh
SSLKEYLOGFILE="/tmp/sslkeylogfile.txt" mitmproxy --mode transparent -s modify_headers.py  -p 1080
```

Эти шаги помогут настроить MITM Proxy так, чтобы минимизировать вероятность его обнаружения сервером【68†source】【69†source】【70†source】.

### 6. Настройка клиентского устройства
Настройте прокси на клиентском устройстве для использования MITM Proxy. В настройках сети укажите IP-адрес и порт вашего MITM Proxy.

### 7. Дополнительные меры
- **Сохранение оригинальных заголовков**: Убедитесь, что заголовки запросов и ответов максимально соответствуют оригинальным.
- **Туннелирование трафика**: Используйте VPN или другие методы для туннелирования трафика, чтобы скрыть факт использования MITM Proxy.
- **Мониторинг времени отклика**: Серверы могут обнаружить MITM по увеличенному времени отклика. Минимизируйте задержки в обработке трафика.
- **Подмена клиентских отпечатков**: Используйте скрипты для подмены отпечатков клиентского ПО, чтобы они соответствовали реальным клиентам.

Эти шаги помогут настроить MITM Proxy так, чтобы минимизировать вероятность обнаружения сервером.

### Еще
Bettercap, mitmproxy, Burp Suite

https://github.com/bettercap/bettercap
https://github.com/mitmproxy/mitmproxy
https://github.com/Ettercap/ettercap
