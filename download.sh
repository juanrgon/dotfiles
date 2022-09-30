#!/bin/bash

set -e

DOTFILES_REPO_DESTINATION=$HOME/github/juanrgon/dotfiles

# Clone dotfiles repo to ~/github/juanrgon/dotfiles
git clone https://github.com/juanrgon/dotfiles.git $DOTFILES_REPO_DESTINATION

# Run dotfiles install script
$DOTFILES_REPO_DESTINATION/install.sh


