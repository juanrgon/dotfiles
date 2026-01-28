######################
# My ZSH configuration
######################

export GITHUB_HANDLE="juanrgon"

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

#####################
# Use nvim instead of vim
#####################
if type -p nvim >/dev/null; then
    alias vim='nvim'
fi

##############
# Setup zoxide
##############
if type -p zoxide >/dev/null; then
    eval "$(zoxide init zsh)"
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

##################################
# Source ~/.local.zsh if it exists
##################################
if [[ -f "$HOME/.local.zsh" ]]; then
    source "$HOME/.local.zsh"
fi

# Add function to change directory using j.sh script
j() {
    target=$("$HOME/github.com/$GITHUB_HANDLE/dotfiles/dotfiles/.config/fish/functions/j.sh" "$@")
    if [[ -d "$target" ]]; then
        cd "$target"
    else
        echo "Directory not found."
    fi
}

export LESS="-RS#3NM~g"

####################
# Starship prompt
####################
if type -p starship >/dev/null; then
    eval "$(starship init zsh)"
else
    setopt PROMPT_SUBST
    export PS1='%B%F{blue}%~ $(git_prompt_info)%f%b
$ '

    # define function to add git information to prompt
    function git_prompt_info() {
      git_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
      if [ $? -eq 0 ]; then
        echo "%{$fg[yellow]%}($git_branch)"
      fi
    }
fi
