# Path to your oh-my-zsh installation.
# 

export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="wezm"

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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(brew terraform common-aliases docker docker-compose git kubectl)

# User configuration

export PATH="/Users/${USER}/.gvm/vertx/current/bin:/Users/${USER}/.gvm/springboot/current/bin:/Users/${USER}/.gvm/lazybones/current/bin:/Users/${USER}/.gvm/jbake/current/bin:/Users/${USER}/.gvm/groovyserv/current/bin:/Users/${USER}/.gvm/groovy/current/bin:/Users/${USER}/.gvm/griffon/current/bin:/Users/${USER}/.gvm/grails/current/bin:/Users/${USER}/.gvm/gradle/current/bin:/Users/${USER}/.gvm/glide/current/bin:/Users/${USER}/.gvm/gaiden/current/bin:/Users/${USER}/.gvm/crash/current/bin:/Users/${USER}/.gvm/asciidoctorj/current/bin:/Users/${USER}/.config/base16-shell:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

### Helper functions

# Determine a command/program exists.
exists() {
  command -v "$1" >/dev/null 2>&1
}

if [ -s ~/.profile ]; then
  source ~/.profile
else
  echo "WARNING: Unable to find to find .profile file"
fi


CURRENT_COMPANY_RC_FILE="~/.flexerc"
[[ -s "${CURRENT_COMPANY_RC_FILE}" ]] && source "${CURRENT_COMPANY_RC_FILE}"

#if [ -n "$DIGITAL_OCEAN_ACCESS_TOKEN" ]; then
#  dm_create_digitalocean() {
#    docker-machine create --driver digitalocean --digitalocean-access-token "${DIGITAL_OCEAN_ACCESS_TOKEN}" "$1"
#  }
#else
#  echo "WARNING: No Digital Ocean access token found."
#fi

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

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

# Custom git push alias 

alias brew_upgrade='brew update && brew upgrade && brew cleanup'
alias dev='cd ~/dev/'

alias vi='nvim'
alias nv='nvim'

alias be='bundle exec'
alias dm='docker-machine'
alias dc='docker-compose'
alias dcr='docker-compose run'
alias d='docker'
alias dclean='docker rm $(docker ps -q -f status=exited) && docker rmi $(docker images -q -f dangling=true)'
alias dmip='docker-machine ip $(docker-machine active)'
alias git='hub'
alias pr='git pull-request'
alias ggpull='git pull origin $(git_current_branch)'
alias tidyxml='tidy -xml -i'
alias gbda="git branch | grep -v "master" | xargs git branch -D"
alias gpme='git push mhotan $(git_current_branch)'
alias gcloud-configure-docker='gcloud auth configure-docker'

# Source ~/.profile if exist.
[[ -s ~/.profile ]] && source ~/.profile

# Base16 Shell
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
# Set the default base16 background color
base16_material-darker

# Configure JEnv
eval "$(jenv init -)"

# NVM / Node environment manager
export NVM_DIR="$HOME/.nvm"
. "$(brew --prefix nvm)/nvm.sh"

#if exists virtualenvwrapper.sh; then
#  source `which virtualenvwrapper.sh`
#fi

HELPDIR=/usr/local/share/zsh/help

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/gettext/bin:$PATH"

# Set nvm environment variable.
export NVM_DIR="$HOME/.nvm"
# Assume brew install nvm already done
. "/usr/local/opt/nvm/nvm.sh"

export PATH=${GOPATH}/bin:$PATH

source ~/.flexe_zshrc

# User RBenv configuration
eval "$(rbenv init -)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/michaelhotan/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/michaelhotan/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/michaelhotan/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/michaelhotan/google-cloud-sdk/completion.zsh.inc'; fi

# The next is to override imagemagick with imagemagick6
# required for some versions of rmagick
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
