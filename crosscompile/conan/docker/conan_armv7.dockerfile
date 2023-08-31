FROM conanio/gcc5-armv7hf

ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:.
ENV GOPATH $HOME/go
ENV GOBIN $GOPATH/bin
ENV PATH $PATH:$GOBIN:/usr/local/go/bin

ADD https://go.dev/dl/go1.18.3.linux-amd64.tar.gz /tmp/go1.18.3.linux-amd64.tar.gz

RUN sudo apt update && \
    sudo apt install -y wget python3 python3-pip python3-dev && \
    sudo python3 -m pip install --upgrade pip && \
    sudo -H pip3 install -U conan && \
    sudo ln -s /usr/arm-linux-gnueabihf/lib/ld-linux-armhf.so.3 /lib/ && \
    sudo tar -C /usr/local -xzf /tmp/go1.18.3.linux-amd64.tar.gz

