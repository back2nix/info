FROM ubuntu:18.04 as builder

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Moscow

# setup for download private go modules
#RUN git config --global url.git@github.com:.insteadOf https://github.com/
#RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com > ~/.ssh/known_hosts

RUN git clone https://github.com/orangepi-xunlong/OrangePi_Build && \
    cd OrangePi_Build && \
    git checkout c3be5573ad969db901fdfb031addaf4959dccc2e

RUN wget http://cdimage.ubuntu.com/ubuntu-base/releases/18.04/release/ubuntu-base-18.04.5-base-arm64.tar.gz && \
    mkdir OrangePiRK3399/output/rootfs &&
    sudo tar xzvf ubuntu-base-18.04.5-base-arm64.tar.gz -C OrangePiRK3399/output/rootfs

RUN apt update && \
    sudo apt install -y bsdtar mtools u-boot-tools pv bc gcc automake make binfmt-support flex \
    lib32z1 lib32z1-dev qemu-user-static bison libncurses5-dev debootstrap  swig libpython2.7-dev \
    libssl-dev python-minimal dos2unix liblz4-tool locales

RUN locale-gen "en_US.UTF-8"

WORKDIR /OrangePiRK3399

COPY . .
# Caching go modules
ARG ARCH
RUN scripts/build.sh

FROM scratch as artifact
COPY --from=builder /OrangePiRK3399/output/* output
