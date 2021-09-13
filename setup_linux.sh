#!/usr/bin/env bash

set -e

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

# Obtain a reference to the directory containing `setup.sh`
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt update && \
  sudo apt install -y curl vim apt-transport-https ca-certificates gnupg

APT_DIR="${BASE_DIR}/etc/apt"
APT_FILE_NAME="${APT_DIR}/apt_packages"
sudo apt-clone restore "${APT_FILE_NAME}.apt-clone.tar.gz"

# Install SDKman for Java, Scala, SBT,
# We will use SDK to
if ! type sdk > /dev/null; then
  curl -s "https://get.sdkman.io" | bash
fi
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java

# Install snap
if ! type snap > /dev/null; then
  echo "Install snap"
  sudo apt install -y snapd
  sudo snap install snap-store
fi

# Install snaps
# Snap does not make it easy to script when some packages are already installed and some applications
# require --classic because those apps manage their own updates.

# SNAPFILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/etc/snapd"
# SNAP_FILE_PATH=${SNAPFILE_DIR}/Snapfile
# snap install $( cat $SNAP_FILE_PATH )

###########################################################################################
## Install shell stuff

if ! type zsh > /dev/null; then
  echo "Install zsh"
  sudo apt install -y zsh
fi

if [ "$(echo $0)" != "zsh" ]; then
  echo "Setting default shell to zsh"
  sudo usermod -s /usr/bin/zsh $(whoami)
  echo "WARN: sudo reboot required for zsh to be default shell"
fi

# Reference: https://github.com/robbyrussell/oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
  echo "Installing Oh My ZSH"
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# Install base16-shell
if [ ! -d ~/.config/base16-shell ]; then
  echo "Downloading base16-shell"
  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
fi

# Install base16-shell
if [ ! -d ~/.config/base16-idea ]; then
  echo "Downloading base16-idea"
  git clone https://github.com/adilosa/base16-idea.git ~/.config/base16-idea
fi

if [ ! -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ]; then
  echo "Downloading powerlevel10k"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Install lab to wrap git or hub
# Reference: https://github.com/zaquestion/lab
if ! type lab > /dev/null; then
  echo "Installing lab"
  curl -s https://raw.githubusercontent.com/zaquestion/lab/master/install.sh | sudo bash
fi

## GCP CLI
if ! type gcloud > /dev/null; then
  echo "Install gcloud"
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
  sudo apt-get update && sudo apt-get install -y google-cloud-sdk
fi

if ! type kubectl > /dev/null; then
  echo "Installing kubectl"
  sudo apt-get install -y kubectl
fi

# Python virtualenvwrapper setup
# echo "Installing tools for managing Python environments"
# pip install virtualenvwrapper

##### Install Awesome VIM
# Reference: https://github.com/amix/vimrc
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
ln -sfn "${BASE_DIR}/my_configs.vim" ~/.vim_runtime/my_configs.vim

#############################################################################################
##### Symlink all necessary home directory files.

echo "Symlinking zshrc"
ln -sfn "${BASE_DIR}/.zshrc" ~/.zshrc

echo "Symlinking tmux config"
ln -sfn "${BASE_DIR}/.tmux.conf" ~/.tmux.conf

echo "Symlinking gitconfig"
ln -sfn "${BASE_DIR}/.gitconfig" ~/.gitconfig
ln -sfn "${BASE_DIR}/.gitconfig_global" ~/.gitconfig_global

#############################################################################################
##### Installing Ruby and Python dependencies.

# Install rsense for Ruby development helper
# gem install rsense

# Install VSCode settings
code --install-extension Shan.code-settings-sync

# Install docker
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic test"
sudo apt update
sudo apt install -y docker-ce

# docker-machine
curl -L https://github.com/docker/machine/releases/download/v0.12.2/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine &&
chmod +x /tmp/docker-machine &&
sudo cp /tmp/docker-machine /usr/local/bin/docker-machine

# docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &&
sudo chmod +x /usr/local/bin/docker-compose

# Virtual box to create different VMs
sudo apt install -y virtualbox