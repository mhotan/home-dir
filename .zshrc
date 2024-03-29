# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
#

export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="wezm"

# Requires brew tap homebrew/cask-fonts && brew cask install font-hack-nerd-font
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="nerdfont-complete"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# OS specific ZSH
case `uname` in
  Darwin)
    # commands for OS X go here
    # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
    # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
    # Example format: plugins=(rails git textmate ruby lighthouse)
    # Add wisely, as too many plugins slow down shell startup.
    plugins=(brew terraform common-aliases docker git kubectl aws)
    export PATH="/Users/${USER}/.gvm/vertx/current/bin:/Users/${USER}/.gvm/springboot/current/bin:/Users/${USER}/.gvm/lazybones/current/bin:/Users/${USER}/.gvm/jbake/current/bin:/Users/${USER}/.gvm/groovyserv/current/bin:/Users/${USER}/.gvm/groovy/current/bin:/Users/${USER}/.gvm/griffon/current/bin:/Users/${USER}/.gvm/grails/current/bin:/Users/${USER}/.gvm/gradle/current/bin:/Users/${USER}/.gvm/glide/current/bin:/Users/${USER}/.gvm/gaiden/current/bin:/Users/${USER}/.gvm/crash/current/bin:/Users/${USER}/.gvm/asciidoctorj/current/bin:/Users/${USER}/.config/base16-shell:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

    # NVM / Node environment manager
    if [[ $(brew list nvm) ]]; then
      export NVM_DIR="$HOME/.nvm"
      . "$(brew --prefix nvm)/nvm.sh"
    fi

  ;;
  Linux)
    # commands for Linux go here
    plugins=(terraform common-aliases docker docker-compose git kubectl node npm nvm virtualenvwrapper)

    # NVM
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

    # Configure tfenv (if properly installed)
    # Reference setup_elementary_6_linux.sh
    . ~/.profile
    if [ -d "$HOME/.tfenv/bin" ]; then
      mkdir -p ~/.local/bin/
      . ~/.profile
      ln -sfn ~/.tfenv/bin/* ~/.local/bin
    fi
  ;;
  FreeBSD)
    # commands for FreeBSD go here
  ;;
esac


### Helper functions

# Determine a command/program exists.
exists() {
  command -v "$1" >/dev/null 2>&1
}

if [ -s ~/.profile ]; then
  source ~/.profile
fi

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export VISUAL=vim
export EDITOR="$VISUAL"
export GIT_EDITOR="$EDITOR"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

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
alias grame='git remote add mhotan $1'
alias gpme='git push mhotan $(git_current_branch)'
alias gcloud-configure-docker='gcloud auth configure-docker'
alias pr='gh pr create --fill'
alias prcloud='gh pr create -T pull_request_template.md'

# Delete branches that matches prefix.
gbDme () {
  pattern=${1:-"mike/|hotan/"}
  printf "%s\n" $(git branch) | grep -E "${pattern}" | xargs git branch -D
}

HELPDIR=/usr/local/share/zsh/help

# The next is to override imagemagick with imagemagick6
# required for some versions of rmagick
# export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"

# Setup Python virtual environments
if [ ! -d ~/dev/python/envs ]; then
  mkdir -p ~/dev/python/envs
  export WORKON_HOME=~/dev/python/envs
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
# Let SDKMAN configure JAVA_HOME
export JAVA_HOME="${SDKMAN_DIR}/candidates/java/current"

[[ -s /usr/share/nvm/init-nvm.sh ]] && source /usr/share/nvm/init-nvm.sh

# Add Google Cloud completions if Google Cloud SDK installed through Snap
GOOGLE_CLOUD_ZSH_COMPLETIONS="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
[[ -f $GOOGLE_CLOUD_ZSH_COMPLETIONS ]] && source $GOOGLE_CLOUD_ZSH_COMPLETIONS

# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/google-cloud-sdk/path.zsh.inc' ]; then . '~/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '~/google-cloud-sdk/completion.zsh.inc' ]; then . '~/google-cloud-sdk/completion.zsh.inc'; fi

# Init oh-my-zsh
source $ZSH/oh-my-zsh.sh

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

if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Add Solana to local path if it exists
if [ -d $HOME/.local/share/solana/install/active_release/bin ]; then
  export PATH=$PATH:$HOME/.local/share/solana/install/active_release/bin
fi

# Add the bin folder to $PATH before the plugins load
PATH=$HOME/.local/bin:$PATH

###############################################################
## OpenSSL@3
# Prefer OpenSSL 3 if it has been installed. I.E. `brew install openssl`

if [ -d '/usr/local/opt/openssl@3/bin' ]; then
  export PATH="/usr/local/opt/openssl@3/bin:$PATH"
fi

###############################################################
## Go setup

# Add go binaries to path
if [[ $(command -v go) ]]; then
  export GOPATH=$HOME/go
  export GOROOT="$(brew --prefix golang)/libexec"
  export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
fi

###############################################################
## Postgres libpq

LIBPQ_BIN_DIR="/usr/local/opt/libpq/bin"
if [ -d $LIBPQ_BIN_DIR ]; then
  export PATH="$LIBPQ_BIN_DIR:$PATH"
fi

###############################################################
## Local non-revision controlled profile

if [ -f ~/.local.zsh ]; then
  source ~/.local.zsh
fi

###############################################################
## zplug

if [ -d $HOME/.zplug ]; then
  source ~/.zplug/init.zsh # Initialize ZPlug

  ## Install Zplugins
  zplug chriskempson/base16-shell, from:github
  zplug romkatv/powerlevel10k, as:theme, depth:1

  ## Load Zplug
  zplug load

  ## Post Load actions
  base16_material-darker
fi

###############################################################
# Python virtual env

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
  export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
  export WORKON_HOME=$HOME/.virtualenvs
  export PROJECT_HOME=$HOME/dev/py_projects
  mkdir -p $WORKON_HOME
  mkdir -p $PROJECT_HOME
  source /usr/local/bin/virtualenvwrapper.sh
fi

###############################################################
# Company specific configuration

export CLOUD_REPO=${HOME}/dev/union.ai/cloud
export AWS_CONFIG_FILE=${CLOUD_REPO}/gen/cli-config/aws
export KUBECONFIG=${HOME}/.kube/config:${CLOUD_REPO}/gen/cli-config/kubeconfig:${HOME}/.kube/kind-config


###############################################################
# fzf fuzzy searcher
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

###############################################################
# pyenv & pyenv-virtualenv

if command -v "pyenv" >/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"

  # auto active virtual envs
  if which pyenv-virtualenv-init > /dev/null; then
    eval "$(pyenv virtualenv-init -)";
  fi
fi


###############################################################
# aws
export AWS_PAGER=""

###############################################################
# krew

if [ -d "${KREW_ROOT:-$HOME/.krew}/bin" ]; then
  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
fi
