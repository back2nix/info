#### errors

# установить все пакеты в определнную папку
PYTHONUSERBASE=/home/bg/install pip3 install --target=/home/bg/install -r requirements.txt
PYTHONUSERBASE=/usr/local/lib/python3.6/dist-packages/ sudo -H pip3 install --target=/usr/local/lib/python3.6/dist-packages/ -r requirements.txt
sudo -H pip3 install -r requirements.txt

# скачать пакет и сбилдить его
sudo -H pip3 download --no-deps onnx==1.8.1
sudo -H pip3 wheel --no-deps onnx-1.8.1.tar.gz

sudo -H pip3 install debugpy

# remote ssh debug
# https://code.visualstudio.com/docs/python/debugging
set -a
source /etc/facechain/.pipeline-v2.env
set +a
python3 -m debugpy --listen 0.0.0.0:5678 -m src.run

# python golang
https://www.ardanlabs.com/blog/2020/08/packaging-python-code.html

### shared memory

- https://bitworks.software/share-ctype-structures-numpy-arrays-between-unrelated-processes-python.html

```
sudo -H pip3 install posix_ipc
```

```
wget https://bootstrap.pypa.io/get-pip.py
python3.10 get-pip.py
update-alternatives --list python
update-alternatives --install /usr/bin/python3 python /usr/local/bin/python3.10 1
```

# tutorial

learnpython.org
