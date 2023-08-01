# Obtain a reference to the directory containing `setup.sh`
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Reference: http://brew.sh/
echo "Installing Homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing Homebrew packages"
brew bundle --file=${BASE_DIR}/etc/brew/Brewfile

# Reference: https://github.com/robbyrussell/oh-my-zsh
echo "Installing Oh My ZSH"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Python virtualenvwrapper setup
echo "Installing tools for managing Python environments"
pip3 install virtualenvwrapper

# Necessary for helper packages. 
echo "Creating ~/.config directories"
# Implictly creates .config
mkdir -p ~/.config/nvim/backup ~/.config/nvim/swap ~/.config/nvim/undo

# Using zplug. Check .zshrc
# Install base16-shell for shell nice colors.
# if [ ! -d ~/.config/base16-shell ]; then
#   echo "Downloading base16-shell"
#   git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
# fi

# Install base16-idea for Intellij nice colors
if [ ! -d ~/.config/base16-idea ]; then
  echo "Downloading base16-idea"
  git clone https://github.com/adilosa/base16-idea.git ~/.config/base16-idea
fi

#############################################################################################
## vimrc 
# https://github.com/amix/vimrc

if [ ! -d "$HOME/.vim_runtime" ]; then
  echo "Installing vim runtime"
  git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
  sh ${HOME}/.vim_runtime/install_awesome_vimrc.sh
fi

##### Dependencies required for current VIM setup for .vimrc
# Required to support vim-github-dashboard
gem install json_pure

#############################################################################################
###### Installing Node.js through nvm (nvm installed through brew)

echo "Creating nvm config directory"
mkdir -p ~/.nvm

# Install latest stable node.js version
nvm install --lts
# Always default to the latest available node version
nvm alias default node
nvm use --lts
npm install -g npx
npm install -g expo-cli


#############################################################################################
##### Setting ZSH as the default shell

BREW_INSTALLED_ZSH="/usr/local/bin/zsh"
if grep -Fxq "${BREW_INSTALLED_ZSH}" /etc/shells
then
  echo "Found ${BREW_INSTALLED_ZSH}, doing nothing"
else
  echo "Did not find ${BREW_INSTALLED_ZSH} adding to shells"
  sudo echo "${BREW_INSTALLED_ZSH}" >> /etc/shells
fi

echo "Attempting to set zsh as the default shell for this user."
sudo chsh -s /usr/local/bin/zsh

#############################################################################################
##### Symlink all necessary home directory files.

echo "Symlinking zshrc"
ln -sfn "${BASE_DIR}/.zshrc" ~/.zshrc

# Using awesome vim defined above.
# echo "Symlinking vimrc for neovim, vimrc, and ideavimrc"
# ln -sfn "${BASE_DIR}/.vimrc" ~/.vimrc
# ln -sfn "${BASE_DIR}/.vimrc" ~/.ideavimrc

echo "Symlinking tmux config"
ln -sfn "${BASE_DIR}/.tmux.conf" ~/.tmux.conf

echo "Symlinking gitconfig"
ln -sfn "${BASE_DIR}/config/git/osx/.gitconfig" ~/.gitconfig
ln -sfn "${BASE_DIR}/config/git/osx/.gitconfig_global" ~/.gitconfig_global

echo "Symlinking p10k config"
ln -sfn "${BASE_DIR}/.p10k.zsh" ~/.p10k.zsh

#############################################################################################
##### Installing Ruby and Python dependencies.

# Install rsense for Ruby development helper
# gem install rsense

# Install VSCode settings
code --install-extension Shan.code-settings-sync

#############################################################################################
##### pyenv-virtualenv setup

if command -v "pyenv" >/dev/null 2>&1; then
  echo "pyenv is already installed"
else
  echo "Installing pyenv"
  if [ ! -d "$HOME/.pyenv/plugins/pyenv-virtualenv" ]; then
    git clone "https://github.com/pyenv/pyenv-virtualenv.git" "$HOME/.pyenv/plugins/pyenv-virtualenv"
  fi
fi
