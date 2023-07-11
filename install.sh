#!/usr/bin/env bash

set -ou pipefail
set -e

# destination for my personal scripts
export PERSONAL_SCRIPTS_DIR="$HOME/bin/juanrgon"

# destination for my shortcuts
export SHORTCUTS_BIN="$HOME/shortcut/bin"

# directory of this script. NOTE: cd and pwd are used to get the absolute path, not the relative path.
THIS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

main() {
    if [[ "${1:-}" == "--debug" ]]; then
        log "Debug mode enabled"
        set -x
    fi

    #######################
    # Change MacOS settings
    #######################
    set_macos_settings

    ####################################################################
    # Install OS packages needed to start fish and install other packages
    ####################################################################
    log "Installing Essential OS packages..."
    install_packages \
        fish \
        rsync \
        git \
        curl

    ##############
    # Sync dotfiles
    ##############
    log "Syncing dotfiles..."
    rsync $THIS_DIR/dotfiles/ $HOME/ -r

    ################################################
    # Copy personal scripts to $PERSONAL_SCRIPTS_DIR
    ################################################
    log "Importing personal scripts..."
    mkdir -p "$PERSONAL_SCRIPTS_DIR"                         # Create personal scripts dir
    cp $THIS_DIR/scripts/* $PERSONAL_SCRIPTS_DIR             # Copy scripts to my personal scripts dir

    # Make personal scripts files executable
    for SCRIPT in $PERSONAL_SCRIPTS_DIR/*;
    do
        if [ -f $SCRIPT ]; then
            chmod +x $SCRIPT
        fi
    done

    export PATH="$PERSONAL_SCRIPTS_DIR:$PATH"
    export SHORTCUT_BIN="$SHORTCUTS_BIN:$PATH"

    #################################################################################
    # Add shortcuts
    #
    # They're like aliases, but they generate bash scripts, so they're shell agnostic
    #################################################################################
    log "Adding shortcuts..."
    shortcut cop    'github-copilot-cli what-the-shell'
    shortcut copgit 'github-copilot-cli git-assist'
    shortcut copgh  'github-copilot-cli gh-assist'
    shortcut d       docker
    shortcut dc      docker compose
    shortcut dcb     docker compose build
    shortcut dcdn    docker compose down
    shortcut dcr     docker compose run --rm
    shortcut dcup    docker compose up
    shortcut dfr     "cd $THIS_DIR && gdn && $THIS_DIR/install.sh"
    shortcut g       git
    shortcut ga      git add
    shortcut gapa    git add --patch
    shortcut gclean  git clean --force -d
    shortcut gcne    git commit --no-edit
    shortcut gco     git checkout
    shortcut gd      git diff
    shortcut gdn     'git pull origin $(git_branch_name)'
    shortcut gdca    git diff --cached
    shortcut gf      git fetch --prune
    shortcut glg     git log --stat
    shortcut grbi    git rebase --interactive
    shortcut grh     git reset HEAD
    shortcut gs      git status
    shortcut gup     'git push origin $(git_branch_name)'

    if os_is_linux; then
        if command -v fdfind &> /dev/null; then
            log "Fixing fd for ubuntu..."
            shortcut fd fdfind
        fi

        if command -v batcat &> /dev/null; then
            shortcut bat batcat
        fi
    fi

    ##################
    # Setup git config
    ##################
    install_git_config $HOME/.config/git/juanrgon.gitconfig

    ########################
    # Install extra packages
    ########################
    log "Installing Extra OS packages..."
    install_packages \
        tldr \
        ripgrep \
        fzf \
        hub \
        vim \
        git \
        htop \
        rsync \
        tree \
        fd \
        cargo \
        httpie \
        less

    install_onepassword_cli

    ###############################
    # Setup rust and cargo packages
    ###############################
    export PATH="$HOME/.cargo/bin:$PATH"
    log "Installing rust packages..."
    cargo install \
        bat \
        exa \
        git-delta \
        chatgpt-cli \
        tokei

    ##########################
    # Add git-delta git config
    ##########################
    install_git_config $HOME/.config/git/delta.gitconfig

    ###################################################################
    # Create shortcuts for rust alternatives to standard POSIX commands
    ###################################################################
    log "Adding rust cli alternative shortcuts..."
    shortcut cat    bat
    shortcut ls     exa
    shortcut l      ls
    shortcut ll     ls --long --icons --group-directories-first --all
    shortcut lt     ls --tree

    #####################################
    # Install macos fonts for development
    #####################################
    macos_install_fonts

    ##############
    # Setup gh cli
    ##############
    setup_gh

    #############
    # Install nvm
    #############
    install_node

    ###############
    # Install pyenv
    ###############
    if [ -d $HOME/.pyenv ]; then
        log "pyenv already installed"
    else
        log "Installing pyenv..."
        curl https://pyenv.run | bash
    fi

    ############################
    # Add git-hooks to this repo
    ############################
    chmod +x $THIS_DIR/git-hooks/*
    rm -rf $THIS_DIR/.git/hooks/*
    mkdir -p $THIS_DIR/.git/hooks/
    cp $THIS_DIR/git-hooks/* $THIS_DIR/.git/hooks/
}

install_packages() {
    PKGS=""
    for pkg in "$@"
    do
        PKGS="$PKGS $(package_name $pkg)"
    done

    if os_is_linux; then
        if user_is_root; then
            apt-get update
        else
            sudo apt-get update
        fi
        PKGS="$PKGS build-essential"
    elif os_is_macos; then
        # Make sure we have brew installed
        if ! command -v brew &> /dev/null; then
            log "Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            export PATH="/opt/homebrew/sbin:/opt/homebrew/bin:$PATH"
        fi
    else
        log "FAILED TO INSTALL PACKAGES"
        log "OS not supported 😔: $OSTYPE"
        exit 1
    fi

    log installing $PKGS

    if os_is_linux; then
        if user_is_root; then
            apt-get install -y $PKGS
        else
            sudo apt-get install -y $PKGS
        fi
    elif os_is_macos; then
        # Make sure we have brew installed
        brew install --quiet $PKGS
    else
        error "OS not supported 😔: $OSTYPE"
    fi
}

# Return the proper package name for the current OS
package_name() {
    case $1 in
        fd)
            if os_is_linux; then
                echo "fd-find"
            elif os_is_macos; then
                echo "fd"
            fi
            ;;
        cargo)
            if os_is_linux; then
                echo "cargo"
            elif os_is_macos; then
                echo "rust"
            fi
            ;;
        *)
            echo $1
            ;;
    esac
}

os_is_linux() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        return 0
    else
        return 1
    fi
}
export -f os_is_linux

os_is_macos() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        return 0
    else
        return 1
    fi
}
export -f os_is_macos

user_is_root() {
    if (( $EUID == 0 )); then
        return 0
    else
        return 1
    fi
}
export -f user_is_root

log() {
    echo "🏠 [dotfiles]: $*"
}
export -f log

error() {
    log "$* 😔"
}
export -f error

install_git_config() {
    GIT_CONFIG="$1"
    if git config --global --get-all include.path | grep "$GIT_CONFIG" > /dev/null; then
        log "$GIT_CONFIG already installed"
    else
        log "Setting up git config..."
        git config --global --add include.path $GIT_CONFIG
    fi
}
export -f install_git_config

function set_macos_settings() {
    if ! os_is_macos; then
        return
    fi

    log "Changing MacOS settings..."

    # Allow key repeat to work in all apps
    defaults write -g ApplePressAndHoldEnabled -bool false

    # Change the default photo save location to ~/Downloads
    defaults write com.apple.screencapture location -string "${HOME}/Downloads"

    # Disable the screenshot thumbnail
    defaults write com.apple.screencapture show-thumbnail -bool false

    # Faster dock hiding and unhiding
    defaults write com.apple.dock autohide-delay -float 0; defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock

    # Make hidden apps visible in the dock
    defaults write com.apple.Dock showhidden -bool TRUE && killall Dock

    # Change the default finder folder to ~/Downloads
    defaults write com.apple.finder NewWindowTarget -string "PfLo"
}

function macos_install_fonts() {
    log "Installing fonts..."

    if ! os_is_macos; then
        return
    fi

    brew tap homebrew/cask-fonts
    brew install \
        font-fira-code-nerd-font \
        font-hasklug-nerd-font
}

function install_onepassword_cli() {
    if os_is_macos; then
        brew install --cask 1password/tap/1password-cli
    fi
}

function setup_gh() {
    # TODO: Support other OSes
    if ! os_is_macos; then
        return
    fi

    log "Setting up gh cli..."
    brew install gh

    # Login to gh if not already logged in
    if ! gh auth status &> /dev/null; then
        log "Logging into gh cli..."
        gh auth login
    fi
}

function install_awscli() {
    if os_is_macos; then
        brew install awscli
    fi
}

function install_node() {
    # Skip if node is already installed
    if command -v node &> /dev/null; then
        log "node already installed"
        return
    fi

    log "Installing node..."

    # TODO: Support other OSes
    if ! os_is_macos; then
        return
    fi

    brew install node
}

main $*
