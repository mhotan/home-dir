# Obtain a reference to the directory containing `setup.sh`
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Reference: http://brew.sh/
echo "Installing Homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing Homebrew packages"
brew install cask
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

# Symlink all necessary home directory files.
ln -sfn "${BASE_DIR}/.zshrc" ~/.zshrc
ln -sfn "${BASE_DIR}/.vimrc" ~/.config/nvim/init.vim

