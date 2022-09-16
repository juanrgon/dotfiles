#!/usr/bin/env bash

set -ou pipefail


main() {
    ###############################################
    # Get the directory in which this script lives.
    ###############################################
    DOTFILES=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

    #####################
    # Install OS packages
    #####################
    echo "Installing OS packages..."
    install_packages \
        fd \
        fish \
        tldr \
        ripgrep \
        fzf \
        hub \
        vim

    # Fix fdfind
    if os_is_linux;
        ln -s /usr/bin/fdfind /usr/bin/fd
    fi


    #######################
    # Setup fish config dir
    #######################
    echo "Creating fish config dir..."
    FISH_CONF_DIR=$HOME/.config/fish
    mkdir -p $FISH_CONF_DIR

    ################################################
    # Copy personal scripts to $PERSONAL_SCRIPTS_DIR
    ################################################
    echo "Importing personal scripts..."
    PERSONAL_SCRIPTS_DIR="$HOME/.juan/bin"                   # destination for my personal scripts
    mkdir -p "$PERSONAL_SCRIPTS_DIR"                         # Create personal scripts dir
    cp $DOTFILES/scripts/* $PERSONAL_SCRIPTS_DIR           # Copy scripts to my personal scripts dir
    chmod +x $PERSONAL_SCRIPTS_DIR/*                         # Make personal scripts files executable

    ##########################
    # Copy over fish functions
    ##########################
    echo "Importing fish functions"
    mkdir -p $FISH_CONF_DIR/functions/
    cp $DOTFILES/.config/fish/functions/fish_prompt.fish $FISH_CONF_DIR/functions/fish_prompt.fish

    #######################
    # Copy over fish config
    #######################
    echo "Importing fish config file..."
    cp $DOTFILES/.config/fish/config.fish $FISH_CONF_DIR/config.fish
}

install_packages() {
    if os_is_linux; then
        if user_is_root; then
            apt-get update
        else
            sudo apt-get update
        fi
    elif os_is_macos; then
        # Make sure we have brew installed
        if ! command -v brew &> /dev/null; then
            echo "Installing brew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
    else
        echo "FAILED TO INSTALL PACKAGES"
        echo "OS not supported 😔: $OSTYPE"
        exit 1
    fi

    for pkg in "$@"
    do
        install_package $pkg
    done
}


install_package() {
    PKG_NAME=$(package_name $1)
    echo installing $PKG_NAME

    if os_is_linux; then
        if user_is_root; then
            apt-get install -y $PKG_NAME
        else
            sudo apt-get install -y $PKG_NAME
        fi
    elif os_is_macos; then
        # Make sure we have brew installed
        brew install $@
    else
        echo "OS not supported 😔: $OSTYPE"
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

main
