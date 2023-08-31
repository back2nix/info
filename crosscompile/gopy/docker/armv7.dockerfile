# sudo docker build -t REPO_DEPRECATED/my-linux-armv7 -f docker/armv7.dockerfile .
# docker run REPO_DEPRECATED/my-linux-armv7 > ~/bin/linux-armv7
# ~/bin/linux-armv7 gopy build -output=binary -vm=`which python3` iface.go
# ~/bin/linux-armv7 bash
#CGO_ENABLED=1 GOOS=linux GOARCH=arm64 gopy build -output=binary -vm=`which python3` iface.go
#FROM dockcross/linux-armv7
#FROM thewtex/cross-compiler-linux-armv7
FROM thewtex/cross-compiler-linux-arm64
#FROM dockcross/linux-arm64

ENV DEFAULT_DOCKCROSS_IMAGE REPO_DEPRECATED/my-linux-armv7
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:.
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:.
ENV GOPATH $HOME/go
ENV GOBIN $GOPATH/bin
ENV PATH $PATH:$GOBIN:/usr/local/go/bin

RUN apt update && \
    apt install -y wget python3 python3-pip  && \
    apt install -y python3-dev; apt install -y -f && \
    python3 -m pip install pybindgen && \
    wget https://go.dev/dl/go1.18.3.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.18.3.linux-amd64.tar.gz && \
    go install golang.org/x/tools/cmd/goimports@latest && \
    go install github.com/go-python/gopy@latest

