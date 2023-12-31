#!/bin/bash

# cd /var/lib/dpkg/info
# rm unattended*

sudo apt update
sudo apt install -y curl git
sudo apt install -y software-properties-common

wget https://raw.githubusercontent.com/REPO_DEPRECATED/info_command/master/config/install_nvim_and_configure.sh
wget https://raw.githubusercontent.com/REPO_DEPRECATED/info_command/master/config/install_tmux.sh
wget https://raw.githubusercontent.com/REPO_DEPRECATED/info_command/master/config/install_zsh.sh

sudo chmod +x install_nvim_and_configure.sh
sudo chmod +x install_tmux.sh
sudo chmod +x install_zsh.sh

./install_nvim_and_configure.sh
./install_tmux.sh
./install_zsh.sh
