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
    elif [[ -f /etc/os-release ]]; then
        if (( $EUID == 0 )); then
            SUDO=""
        else
            SUDO="sudo"
        fi

        DISTRO=$(cat /etc/os-release | grep ID_LIKE |  cut -d "=" -f 2 | tr -d '"' | cut -d " " -f 1)

        case $DISTRO in
            debian)
                $SUDO apt update && $SUDO apt install -y git
                ;;
            centos|redhat)
                $SUDO yum install -y git
                ;;
            arch)
                $SUDO pacman -Sy --noconfirm git
                ;;
            *)
                echo "Please install git manually, then try again"
                exit 1
        esac
    else
        echo "Please install git manually, then try again"
        exit 1
    fi
}

main
