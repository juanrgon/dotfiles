#!/usr/bin/env bash

set -eou pipefail

###############################################
# Get the directory in which this script lives.
###############################################
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

sudo apt-get update
sudo apt-get install -y \
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

###############################
# Copy personal scripts to PATH
###############################
PERSONAL_SCRIPTS_DIR="$HOME/.juan/scripts"      # destination for my personal scripts
mkdir -p "$PERSONAL_SCRIPTS_DIR/.juan/scrips/"  # Create personal scripts dir
chmod +x scripts/*                              # Make personal scripts files executable
cp $SCRIPT_DIR/scripts/* $PERSONAL_SCRIPTS_DIR  # Copy scripts to my personal scripts dir
# Add export statment to fish config file
(cat >> $FISH_CONF_DIR/config.fish) <<PATH_EXPORT_STMT

##############################
# Add personal scripts to PATH
##############################
set -gx PATH $PERSONAL_SCRIPTS_DIR $PATH
PATH_EXPORT_STMT

##################
# Set shell prompt
##################
mkdir -p $FISH_CONF_DIR/functions/
cp $SCRIPT_DIR/.config/fish/functions/fish_prompt.fish $FISH_CONF_DIR/functions/fish_prompt.fish
