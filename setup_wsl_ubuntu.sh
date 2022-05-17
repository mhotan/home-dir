#!/usr/bin/env bash

set -e

# Obtain a reference to the directory containing `setup.sh`
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt update && \
  sudo apt install -y curl vim apt-transport-https ca-certificates gnupg apt-clone aptitude synaptic \
                        software-properties-common && \
  sudo apt update

# Install snap
if ! type snap > /dev/null; then
  echo "Install snap"
  sudo apt install -y snapd
fi

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
  sudo apt-get update && sudo apt-get install google-cloud-cli
fi

if ! type nvm > /dev/null; then
  echo "Installing NVM"
  curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
fi

#if ! type kubectl > /dev/null; then
#  echo "Installing kubectl"
#  sudo apt-get install -y kubectl
#fi

# Python virtualenvwrapper setup
# echo "Installing tools for managing Python environments"
# pip install virtualenvwrapper

##### Install Awesome VIM
# Reference: https://github.com/amix/vimrc
if [ ! -d ~/.vim_runtime ]; then
  git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
fi
sh ~/.vim_runtime/install_awesome_vimrc.sh
ln -sfn "${BASE_DIR}/my_configs.vim" ~/.vim_runtime/my_configs.vim

# Install tfenv to manage different terraform versions
# Terraform used to manage Infrastructure across all projects.
# Ref: https://github.com/tfutils/tfenv#manual
if [ ! -d ~/.tfenv ]; then
  echo "Install tfenv"
  git clone https://github.com/tfutils/tfenv.git ~/.tfenv
fi

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
# code --install-extension Shan.code-settings-sync

# Install docker
# https://docs.docker.com/engine/install/ubuntu/
sudo snap install docker
sudo apt-get install docker-compose
