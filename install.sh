#!/usr/bin/env bash

set -ou pipefail
set -e

PERSONAL_SCRIPTS_DIR="$HOME/bin/juanrgon"   # destination for my personal scripts
THIS_DIR="$(dirname "${BASH_SOURCE[0]}")"   # directory of this script

main() {
    ###############################################
    # Get the directory in which this script lives.
    ###############################################
    DOTFILES=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

    #####################
    # Install OS packages
    #####################
    log "Installing OS packages..."
    install_packages \
        fish \
        tldr \
        ripgrep \
        fzf \
        hub \
        vim \
        git \
        htop \
        curl

    #################################
    # Install rust and cargo packages
    #################################
    log "Installing rust..."
    $THIS_DIR/install/rust.sh -y
    export PATH="$HOME/.cargo/bin:$PATH"
    cargo install \
        exa \
        procs \
        fd-find \
        git-delta


    #######################
    # Setup fish config dir
    #######################
    log "Creating fish config dir..."
    FISH_CONF_DIR=$HOME/.config/fish
    mkdir -p $FISH_CONF_DIR

    ################################################
    # Copy personal scripts to $PERSONAL_SCRIPTS_DIR
    ################################################
    log "Importing personal scripts..."
    mkdir -p "$PERSONAL_SCRIPTS_DIR"                         # Create personal scripts dir
    cp $DOTFILES/scripts/* $PERSONAL_SCRIPTS_DIR             # Copy scripts to my personal scripts dir

    # Make personal scripts files executable
    for SCRIPT in $PERSONAL_SCRIPTS_DIR/*;
    do
        if [ -f $SCRIPT ]; then
            chmod +x $SCRIPT
        fi
    done

    # Fix fdfind on linux
    if os_is_linux; then
        if ! [ -L $PERSONAL_SCRIPTS_DIR/fd ]; then
            ln -s $PERSONAL_SCRIPTS_DIR/fdfind $PERSONAL_SCRIPTS_DIR/fd
        fi
    fi

    #################
    # Setup git delta
    #################
    git config --add $THIS_DIR/.config/delta/themes.gitconfig

    ##########################
    # Copy over fish functions
    ##########################
    log "Importing fish functions"
    mkdir -p $FISH_CONF_DIR/functions/
    cp $DOTFILES/.config/fish/functions/* $FISH_CONF_DIR/functions/

    #######################
    # Copy over fish config
    #######################
    log "Importing fish config file..."
    cp $DOTFILES/.config/fish/config.fish $FISH_CONF_DIR/config.fish

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
            $THIS_DIR/install/homebrew.sh
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
            sudo apt-get install -y $PKG_NAME
        fi
    elif os_is_macos; then
        # Make sure we have brew installed
        brew install $@
    else
        error "OS not supported 😔: $OSTYPE"
    fi
}

# Return the proper package name for the current OS
package_name() {
    if [ $1 == "fd" ]; then
        if os_is_linux; then
            echo "fd-find"
        elif os_is_macos; then
            echo "fd"
        fi
    else
        echo $1
    fi
}

os_is_linux() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        return 0
    else
        return 1
    fi
}

os_is_macos() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        return 0
    else
        return 1
    fi
}

user_is_root() {
    if (( $EUID == 0 )); then
        return 0
    else
        return 1
    fi
}

make_fish_default_shell() {
    FISH_PATH=$(which fish)

    if ! grep -q fish /etc/shells; then
        if user_is_root; then
            echo $FISH_PATH >> /etc/shells
        else
            echo $FISH_PATH | sudo tee -a /etc/shells
        fi
    fi

    log "Setting fish as default shell..."
    chsh -s $FISH_PATH
}

log() {
    echo "🏠 [dotfiles]: $*"
}

error() {
    log "$* 😔"
}

main
