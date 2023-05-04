# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(ag aliases alias-finder aws cp docker docker-compose dotenv gh git git-auto-fetch git-flow git-lfs golang httpie node npm pip ssh-agent sudo terraform virtualenvwrapper yarn)
source $ZSH/oh-my-zsh.sh

################################################################################################
### Environment Variables

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
# You may need to manually set your language environment
export LANG=en_US.UTF-8
export VISUAL=vim
export EDITOR="$VISUAL"
export GIT_EDITOR="$EDITOR"
export SSH_KEY_PATH="~/.ssh/id_rsa" # ssh

################################################################################################
### Aliases and Functions

# Determine a command/program exists.
exists() {
  command -v "$1" >/dev/null 2>&1
}

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias dev='cd ~/dev/'
alias vi='vim'
alias be='bundle exec'
alias d='docker'
alias dclean='docker rm $(docker ps -q -f status=exited) && docker rmi $(docker images -q -f dangling=true)'
alias dmip='docker-machine ip $(docker-machine active)'
alias dc='docker compose'
alias ggpull='git pull origin $(git_current_branch)'
alias tidyxml='tidy -xml -i'
alias gpme='git push michael $(git_current_branch)'
alias gbDme='git branch -D $(printf "%s\n" $(git branch) | grep 'michael/')'
alias gcloud-configure-docker='gcloud auth configure-docker'
alias pr='gh pr create --fill'

################################################################################################
### Source files

if [ -s ~/.profile ]; then
  source ~/.profile
fi

if [ -f ~/.local.zsh ]; then
  source ~/.local.zsh
fi

# Not specified to be last line but for convention leave p10k as last 
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

################################################################################################
### Configure Development Package Managers

# Homebrew
HOMEBREW_PREFIX=$(brew --prefix)
if [ -x $HOMEBREW_PREFIX/bin/brew ]; then
  # Set HOMEBREW environment variables
  eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"
fi

# Node (NVM, etc)
NVM_DIR=$(brew --prefix nvm)
if [ -d $NVM_DIR ]; then
  source ${NVM_DIR}/nvm.sh
  source ${NVM_DIR}/etc/bash_completion.d/nvm
fi

# Python
if [ ! -d ~/dev/python/envs ]; then
  mkdir -p ~/dev/python/envs
  export WORKON_HOME=~/dev/python/envs
fi

# JVM Based Stuff
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export JAVA_HOME="${SDKMAN_DIR}/candidates/java/current"

# Go
# Add Go binaries to path
if [[ $(command -v go) ]]; then
  export PATH=$PATH:$(go env GOPATH)/bin
fi

################################################################################################
### Tools

# Android
if [ -d $HOME/Android/Sdk ]; then\
  # Windows WSL2
  export ANDROID_HOME=$HOME/Android/Sdk
  export PATH=$PATH:$ANDROID_HOME/emulator
  export PATH=$PATH:$ANDROID_HOME/tools
  export PATH=$PATH:$ANDROID_HOME/tools/bin
  export PATH=$PATH:$ANDROID_HOME/platform-tools
elif [ -d $HOME/Library/Android/sdk ]; then
  # MacOS
  export ANDROID_HOME=$HOME/Library/Android/sdk
  export PATH=$PATH:$ANDROID_HOME/emulator
  export PATH=$PATH:$ANDROID_HOME/tools
  export PATH=$PATH:$ANDROID_HOME/tools/bin
  export PATH=$PATH:$ANDROID_HOME/platform-tools
fi

## OpenSSL@3 
# Prefer OpenSSL 3 if it has been installed. I.E. `brew install openssl`
if [ -d '/usr/local/opt/openssl@3/bin' ]; then
  export PATH="/usr/local/opt/openssl@3/bin:$PATH"
fi

## Postgres libpq
LIBPQ_DIR=$(brew --prefix libpq)
if [ -d "${LIBPQ_DIR}/bin" ]; then
  export PATH="$PATH:$LIBPQ_DIR/bin"
fi

## zplug
ZPLUG_DIR=$(brew --prefix zplug)
if [ -d $HOME/.zplug ]; then
  source ~/.zplug/init.zsh # Initialize ZPlug

  ## Install Zplugins
  zplug chriskempson/base16-shell, from:github

  ## Load Zplug
  zplug load

  ## Post Load actions
  base16_material-darker
fi