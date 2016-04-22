# Obtain a reference to the directory containing `setup.sh`
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Reference: http://brew.sh/
echo "Installing Homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing Homebrew packages"
brew install cask
# brew cask list does not list packages by dependencies.  However many packages require java.
# Therefore explicitly install java first.
brew cask install java
brew install $(cat "${BASE_DIR}/etc/casks")
brew cask install $(cat "${BASE_DIR}/etc/caskroom_casks")

# Reference: https://github.com/robbyrussell/oh-my-zsh
echo "Installing Oh My ZSH"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Creating ~/.config directories"
# Implictly creates .config
mkdir -p ~/.config/nvim/backup ~/.config/nvim/swap ~/.config/nvim/undo

# Install base16-shell
if [ ! -d ~/.config/base16-shell ]; then
  echo "Install base16-shell"
  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
fi

echo "Fixing Ctrl+h issue for neovim"
infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
tic $TERM.ti

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

echo "Symlinking vimrc for neovim, vimrc, and ideavimrc"
ln -sfn "${BASE_DIR}/.vimrc" ~/.config/nvim/init.vim
ln -sfn "${BASE_DIR}/.vimrc" ~/.vimrc
ln -sfn "${BASE_DIR}/.vimrc" ~/.ideavimrc

echo "Symlinking tmux config"
ln -sfn "${BASE_DIR}/.tmux.conf" ~/.tmux.conf

echo "Symlinking gitconfig"
ln -sfn "${BASE_DIR}/.gitconfig" ~/.gitconfig
ln -sfn "${BASE_DIR}/.gitconfig_global" ~/.gitconfig_global


