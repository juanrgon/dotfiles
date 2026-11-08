#!/bin/bash

set -e

DOTFILES_REPO="juanrgon/dotfiles"

main() {
    # Install git if it's not installed
    if ! command -v git > /dev/null; then
        install_git
    fi

    DOTFILES_REPO_DESTINATION=$HOME/github.com/$DOTFILES_REPO

    # Clone dotfiles repo to ~/github.com dir
    if [ -d $DOTFILES_REPO_DESTINATION ]; then
        cd $DOTFILES_REPO_DESTINATION
        git pull
    else
        git clone https://github.com/$DOTFILES_REPO.git $DOTFILES_REPO_DESTINATION
    fi

    # Run dotfiles install script
    source $DOTFILES_REPO_DESTINATION/install.sh
}

install_git() {
    echo Installing git

    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install git
    elif [[ "$OSTYPE" == "linux"* ]]; then
        if (( $EUID == 0 )); then
            SUDO=""
        else
            SUDO="sudo"
        fi

        # Pick by package manager. Plain Debian and Arch have no ID_LIKE in /etc/os-release.
        if command -v apt-get > /dev/null; then
            $SUDO apt-get update && $SUDO apt-get install -y git
        elif command -v pacman > /dev/null; then
            $SUDO pacman -Syu --needed --noconfirm git
        elif command -v yum > /dev/null; then
            $SUDO yum install -y git
        else
            echo "Please install git manually, then try again"
            exit 1
        fi
    else
        echo "Please install git manually, then try again"
        exit 1
    fi
}

main
