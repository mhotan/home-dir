# Path to your oh-my-zsh installation.
export ZSH=/Users/michaelhotan/.oh-my-zsh

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
plugins=(aws brew common-aliases docker sbt tmux tmuxinator git python)

# User configuration

export PATH="/Users/michaelhotan/.gvm/vertx/current/bin:/Users/michaelhotan/.gvm/springboot/current/bin:/Users/michaelhotan/.gvm/lazybones/current/bin:/Users/michaelhotan/.gvm/jbake/current/bin:/Users/michaelhotan/.gvm/groovyserv/current/bin:/Users/michaelhotan/.gvm/groovy/current/bin:/Users/michaelhotan/.gvm/griffon/current/bin:/Users/michaelhotan/.gvm/grails/current/bin:/Users/michaelhotan/.gvm/gradle/current/bin:/Users/michaelhotan/.gvm/glide/current/bin:/Users/michaelhotan/.gvm/gaiden/current/bin:/Users/michaelhotan/.gvm/crash/current/bin:/Users/michaelhotan/.gvm/asciidoctorj/current/bin:/Users/michaelhotan/.rbenv/shims:/Users/michaelhotan/.rbenv/shims:/Users/michaelhotan/.rbenv/bin:/Users/michaelhotan/.config/base16-shell:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

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
export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias apps-marathon='cd ~/Developer/Socrata/apps-marathon'
alias tasks-chronos='cd ~/Developer/Socrata/tasks-chronos'
alias balboa='cd ~/Developer/Socrata/balboa'
alias brew_upgrade='brew update && brew upgrade && update_neovim && brew cleanup'
alias dev='cd ~/Developer'
alias hep='cd ~/Developer/Socrata/hephaestus'
alias met='cd ~/Developer/Socrata/metachef'
alias metc='cd ~/Developer/Socrata/metachef/cookbooks'
alias vi='vim'
alias nv='nvim'
alias soc='cd ~/Developer/Socrata'
alias dm='docker-machine'
alias dc='docker-compose'
alias d='docker'
alias desoc='eval $(docker-machine env socrata)'
alias dechef='eval $(docker-machine env chef)'
alias dmip='docker-machine ip $(docker-machine active)'
alias git='hub'
alias pr='git pull-request'

# Base16 Shell
export BASE16_DEFAULT="base16-tomorrow.dark"
BASE16_SHELL="$HOME/.config/base16-shell/${BASE16_DEFAULT}.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# User RBenv configuration
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Configure JEnv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# Autocomplete for awscli
# mandated by distribution of aws with Homebrew `brew install awscli`
source /usr/local/share/zsh/site-functions/_aws

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/michaelhotan/.gvm/bin/gvm-init.sh" ]] && source "/Users/michaelhotan/.gvm/bin/gvm-init.sh"
export PATH="/usr/local/sbin:$PATH"

HELPDIR=/usr/local/share/zsh/help
