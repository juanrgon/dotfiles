#!/usr/bin/env bash

# Use this script to test installing dotfiles in a fresh Ubuntu docker container

docker run --platform linux/amd64 -v $(pwd):/dotfiles -w /dotfiles --rm -it ubuntu bash -c "./install.sh && exec fish"

