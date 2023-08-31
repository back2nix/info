FROM thewtex/cross-compiler-linux-armv7

ENV DEFAULT_DOCKCROSS_IMAGE REPO_DEPRECATED/my-linux-armv7
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:.
ENV GOPATH $HOME/go
ENV GOBIN $GOPATH/bin
ENV PATH $PATH:$GOBIN:/usr/local/go/bin

ADD https://github.com/Kitware/CMake/releases/download/v3.24.0-rc1/cmake-3.24.0-rc1-linux-x86_64.sh /tmp/cmake-3.24.0-rc1-linux-x86_64.sh
ADD https://github.com/conan-io/conan/releases/latest/download/conan-ubuntu-64.deb /tmp/conan-ubuntu-64.deb
ADD https://go.dev/dl/go1.18.3.linux-amd64.tar.gz /tmp/go1.18.3.linux-amd64.tar.gz

RUN apt update && \
    apt remove -y cmake && \
    apt install -y wget python3 python3-pip python3-dev; apt install -y -f && \
    tar -C /usr/local -xzf /tmp/go1.18.3.linux-amd64.tar.gz && \
    sh /tmp/cmake-3.24.0-rc1-linux-x86_64.sh --prefix=/usr --skip-license && \
    dpkg -i /tmp/conan-ubuntu-64.deb

