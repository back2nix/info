FROM ubuntu:20.04
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    ln -fs /usr/share/zoneinfo/Europe/Moscow /etc/localtime

LABEL maintainer="REPO_DEPRECATED@list.ru"

ENV DEBIAN_FRONTEND=noninteractive
ENV CUSTOM_NVIM_PATH=/usr/bin/nvim

# Testing install nvim on system
RUN apt update && \
    apt install -y software-properties-common wget sudo && \
    wget https://raw.githubusercontent.com/REPO_DEPRECATED/info_command/master/config/install_nvim_and_configure.sh && \
    chmod +x install_nvim_and_configure.sh && \
    ./install_nvim_and_configure.sh
