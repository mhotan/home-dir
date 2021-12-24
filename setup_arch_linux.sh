#!/usr/bin/env bash

set -e

# Obtain a reference to the directory containing `setup.sh`
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Install all required packages through pacman
#   Skip confirmation messages and only require packages that are required
sudo pacman -Syyu
sudo pacman --sync --noconfirm --needed \
  snapd \
  tldr \
  base-devel \
  yay \
  community/oh-my-zsh \
  nvm \
  git \
  community/github-cli \
  community/aws-cli \
  community/terraform \
  core/curl \
  community/docker \
  community/docker-compose \
  community/docker-machine \
  community/virtualbox \
  unzip \
  zip \
  community/discord \
  extra/vim

## Commenting out yay because of interactive shell is inconvenient
#yay -S --answerclean All --answerdiff All aur/gitlab-glab-bin aur/insync \


# Snapd and Snap store
# Install applications that are snap managed 
sudo systemctl enable --now snapd.socket
sudo snap install snap-store

## Install necessary applications through snap store
# snap symlink
# https://forum.snapcraft.io/t/fedora-29-cant-install-classic-snaps/10342

if [[ ! -L "/snap" ]]; then
  sudo ln -s /var/lib/snapd/snap /snap  
fi
sudo snap install code --classic
# Install VSCode settings
echo "Installing Visual Studio Code"
code --install-extension Shan.code-settings-sync

# Install Android Studio
echo "Installing Android Studio"
sudo snap install android-studio --classic

echo "Installing Intellij Community"
sudo snap install intellij-idea-community --classic

echo "Installing GitKraken"
sudo snap install gitkraken --classic

# Install SDKman for Java, Scala, Kotlin, Gradle, SBT, etc
# We will use SDK to
if ! type sdk > /dev/null; then
  curl -s "https://get.sdkman.io" | bash
fi
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java

##################################################################################################
## Shell

echo "Configuring Shell"

# Oh-my-zsh install and configure zsh to default shell
if [ ! -d $HOME/.oh-my-zsh ]; then
  echo "Installing oh my zsh"
  # Requires oh-my-zsh to be installed above
  /usr/share/oh-my-zsh/tools/install.sh
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

echo "Symlinking zshrc"
ln -sfn "${BASE_DIR}/.zshrc" ~/.zshrc

# Symlinking p10k configuration does not appear to work
# Results in configuring p10k for each new development machine
#echo "Symlinking p10k configuration"
#ln -sfn "${BASE_DIR}/etc/.p10k.zsh" ~/.p10k.zsh

echo "Symlinking tmux config"
ln -sfn "${BASE_DIR}/.tmux.conf" ~/.tmux.conf

echo "Symlinking gitconfig"
ln -sfn "${BASE_DIR}/.gitconfig" ~/.gitconfig
ln -sfn "${BASE_DIR}/.gitconfig_global" ~/.gitconfig_global

echo "Done Configuring Shell"

##################################################################################################
## Node

# Ensure nvm is configured through the shell 
touch ~/.zshrc
if ! grep -q "source /usr/share/nvm/init-nvm.sh" ~/.zshrc; then
  echo "Adding init-nvm.sh to zshrc"
  echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.zshrc
fi
source /usr/share/nvm/init-nvm.sh
# Install npm
nvm install --lts
npm install -g --force npm
npm install -g npx
npm install -g expo-cli
