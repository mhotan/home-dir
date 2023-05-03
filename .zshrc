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
    plugins=(brew terraform common-aliases docker git kubectl)
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

    # Initialize packages installed with Homebrew
    export HOMEBREW_PACKAGES="$HOME/linuxbrew/.linuxbrew"
    
    export ZPLUG_HOME="$HOMEBREW_PACKAGES/opt/zplug"
    if [ -d $ZPLUG_HOME ]; then
      source $ZPLUG_HOME/init.zsh

      ## Install Zplugins
      zplug chriskempson/base16-shell, from:github
      zplug romkatv/powerlevel10k, as:theme, depth:1

      ## Post Load actions
      base16_material-darker
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