#!/usr/bin/env bash

set -ou pipefail

###############################################
# Get the directory in which this script lives.
###############################################
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

#####################
# Install OS packages
#####################
sudo apt-get update
sudo apt-get install -y --no-install-recommends \
    fd-find \
    fish \
    tldr \
    ripgrep \
    fzf \
    hub

#######################
# Setup fish config dir
#######################
FISH_CONF_DIR=$HOME/.config/fish
mkdir -p $FISH_CONF_DIR
touch $FISH_CONF_DIR/config.fish

################################################
# Copy personal scripts to $PERSONAL_SCRIPTS_DIR
################################################
PERSONAL_SCRIPTS_DIR="$HOME/.juan/bin"                   # destination for my personal scripts
mkdir -p "$PERSONAL_SCRIPTS_DIR"                         # Create personal scripts dir
cp $SCRIPT_DIR/scripts/* $PERSONAL_SCRIPTS_DIR           # Copy scripts to my personal scripts dir
chmod +x $PERSONAL_SCRIPTS_DIR/*                         # Make personal scripts files executable

##########################
# Copy over fish functions
##########################
mkdir -p $FISH_CONF_DIR/functions/
cp $SCRIPT_DIR/.config/fish/functions/fish_prompt.fish $FISH_CONF_DIR/functions/fish_prompt.fish

#######################
# Copy over fish config
#######################
cp $SCRIPT_DIR/.config/fish/config.fish $FISH_CONF_DIR/config.fish
