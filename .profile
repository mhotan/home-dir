# .profile sets environment variables that do not require interactive shells.
# Instead they are "login" shells.

############################################################
### Dependencies
############################################################


# Base16 is a shell color theme configurator.
# has a good set of defaults.
# Add Base16 to my Path
export PATH="$HOME/.config/base16-shell:$PATH"
export BASE16_DEFAULT="base16-tomorrow.dark"
export HOMEBREW_GITHUB_API_TOKEN="62aea8600ccc082be58d447a4034c3c32ac2fe1e"
export BROWSER=google-chrome
export OPSCODE_USER=michael_hotan

# Initialize RBenv
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Export GITHUB credentials for hub command line application.
[[ -s ~/.github_profile ]] && source ~/.github_profile

# GOPATH is a common environment variable dependency for GO programming language.
export GOPATH="/usr/local/bin"
export GOROOT="/usr/local/opt/go/libexec/bin"

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/michaelhotan/.gvm/bin/gvm-init.sh" ]] && source "/Users/michaelhotan/.gvm/bin/gvm-init.sh"
