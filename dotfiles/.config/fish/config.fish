################
# My fish config
################

############
# Cheatsheet
############
# "set --universal" sets a variable in ALL fish shells, current and future
# "set --export" sets a variable in the current shell, and in its future child processes

#####################################
# Add my personal scripts to the PATH
#####################################
set --export PERSONAL_SCRIPTS_DIR $HOME/bin/juanrgon    # destination for my personal scripts
mkdir -p $PERSONAL_SCRIPTS_DIR                          # Create personal scripts dir

# NOTE using "set --universal" instead of "set --export" on fish_user_paths would cause it to get longer on each new shell
set --export fish_user_paths $PERSONAL_SCRIPTS_DIR $fish_user_paths  # add personal scripts dir to the PATH

######################################
# Add my shortcuts bin dir to the PATH
######################################
set SHORTCUTS_BIN "$HOME/shortcut/bin"
if test -d $SHORTCUTS_BIN
    set --export fish_user_paths "$SHORTCUTS_BIN" $fish_user_paths
end

##################################
# Add homebrew bin dir to the PATH
##################################
switch (uname)
    case Darwin
        if test -d /opt/homebrew/bin
            set --export fish_user_paths /opt/homebrew/bin $fish_user_paths
        end

        if test -d /opt/homebrew/sbin
            set --export fish_user_paths /opt/homebrew/sbin $fish_user_paths
        end
end

#################################
# Add Cargo's bin dir to the PATH
#################################
if test -d $HOME/.cargo/bin
    set --export fish_user_paths $HOME/.cargo/bin $fish_user_paths  # add personal scripts dir to the PATH
end

#######################################
# Set code as EDITOR if it is installed
#######################################
if type --quiet code
    set --export EDITOR "code --wait"
end

#############
# Setup pyenv
#############
set --export PYENV_ROOT $HOME/.pyenv
if test -d $PYENV_ROOT/bin
    set --export fish_user_paths $PYENV_ROOT/bin $fish_user_paths
    pyenv init - | source

    if type --quiet pyenv-virtualenv-init
        pyenv virtualenv-init - | source
    end
end

############
# Set GOPATH
############
if test -d $HOME/go
    set --export GOPATH $HOME/go
    set --export PATH $GOPATH/bin $PATH
end

########################
# n node version manager
########################
set --export N_PREFIX "$HOME/n"; contains "$N_PREFIX/bin" $PATH; or set --prepend PATH "$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

##############################
# ruby - rbenv version manager
##############################
if test -d $HOME/.rbenv
    status --is-interactive; and rbenv init - fish | source
end

################################################################################
# Load 1Password CLI plugins if available
# This script checks for and sources the 1Password CLI plugins configuration.
# It enables additional functionality for the 1Password CLI tool, such as
# custom commands or integrations with other tools.
# Ensure the 1Password CLI is installed and properly set up for this to work.
# Important: This allows for seamless use of 1Password features in shell scripts.
################################################################################
if test -f $HOME/.config/op/plugins.sh
    source /Users/juanrgon/.config/op/plugins.sh
end

#################################################################################
# Source local.config.fish if it exists
# NOTE: This should always be at the end to allow overriding of previous settings
#################################################################################
if test -f $HOME/.config/fish/local.config.fish
    source $HOME/.config/fish/local.config.fish
end

# Use delta for THOR_DIFF, if delta is installed
if type -q delta
    set --export THOR_DIFF delta
end
