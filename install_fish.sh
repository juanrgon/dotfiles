#!/usr/bin/env bash

set -eou pipefail

# exit if fish is already installed
if [ -x "$(command -v fish)" ]; then
    echo fish is already installed
    exit 0
fi

sudo apt-get update
sudo apt-get install -y fish
chsh -s /usr/bin/fish
