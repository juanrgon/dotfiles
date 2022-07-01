#!/usr/bin/env bash

set -eou pipefail

# Get the directory in which this script lives.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Install Fish shell
echo "Installing fish..."
$SCRIPT_DIR/install_fish.sh

# Clone config files
