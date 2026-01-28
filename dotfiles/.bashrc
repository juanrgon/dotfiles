#######################
# My Bash configuration
#######################

export GITHUB_HANDLE="juanrgon"  # My GitHub handle

##################################
# Add personal scripts to the PATH
##################################
export PERSONAL_SCRIPTS_DIR="$HOME/bin/$GITHUB_HANDLE"
mkdir -p "$PERSONAL_SCRIPTS_DIR"
export PATH="$PERSONAL_SCRIPTS_DIR:$PATH"

######################################
# Add my shortcuts bin dir to the PATH
######################################
export SHORTCUTS_BIN="$HOME/shortcut/bin"
if [[ -d "$SHORTCUTS_BIN" ]]; then
    export PATH="$SHORTCUTS_BIN:$PATH"
fi

##################################
# Add homebrew bin dir to the PATH
##################################
case $(uname) in
    Darwin)
        if [[ -d /opt/homebrew/bin ]]; then
            export PATH="/opt/homebrew/bin:$PATH"
        fi

        if [[ -d /opt/homebrew/sbin ]]; then
            export PATH="/opt/homebrew/sbin:$PATH"
        fi
        ;;
esac

#################################
# Add Cargo's bin dir to the PATH
#################################
if [[ -d "$HOME/.cargo/bin" ]]; then
    export PATH="$HOME/.cargo/bin:$PATH"  # add personal scripts dir to the PATH
fi

#######################################
# Set code as EDITOR if it is installed
#######################################
if type -p code >/dev/null; then
    export EDITOR="code --wait"
fi

##############
# Setup zoxide
##############
if type -p zoxide >/dev/null; then
    eval "$(zoxide init bash)"
fi

#############
# Setup pyenv
#############
if type -p pyenv >/dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"

    if type -p pyenv-virtualenv-init >/dev/null; then
        eval "$(pyenv virtualenv-init -)"
    fi
fi

#####################################
# Source ~/.local.bashrc if it exists
#####################################
if [[ -f "$HOME/.local.bashrc" ]]; then
    source "$HOME/.local.bashrc"
fi

# Add function to change directory using j.sh script
j() {
    target=$("j-search" "$@")
    if [ -d "$target" ]; then
        cd "$target"
    else
        echo "Directory not found."
    fi
}

# Add function to change directory using j.sh script
je() {
    # Jump to a repo and open it in the editor
    j "$@"

    # if EDITOR includes "--wait" (e.g. for VSCode or Cursor's `code` and `cursor` commands), remove it,
    # otherwise the current editor window will be replaced, instead of a new one being opened.
    EDITOR_COMMAND=$(echo "$EDITOR" | sed 's/--wait//')
    $EDITOR_COMMAND "$@"
}

. ~/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export LESS="-RS#3NM~g"

####################
# Starship prompt
####################
if type -p starship >/dev/null; then
    eval "$(starship init bash)"
else
    export PS1='\n\[\033[01;34m\]\w \[\033[01;33m\]$(__git_ps1 " (%s)")\[\033[00m\]\n\$ '
fi
