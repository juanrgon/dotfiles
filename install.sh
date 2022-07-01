#!/usr/bin/env bash

set -eou pipefail

# Get the directory in which this script lives.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

sudo apt-get update
sudo apt-get install -y \
    fish \
    tldr \
    ripgrep \
    fzf \
    hub

# Copy personal scripts to PATH
chmod +x scripts/*
cp $SCRIPT_DIR/scripts/* $HOME/.local/bin

# Set fish prompt
mkdir -p $HOME/.config/fish/functions/
cp $SCRIPT_DIR/.config/fish/functions/fish_prompt.fish $HOME/.config/fish/functions/fish_prompt.fish
