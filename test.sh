#!/usr/bin/env bash
docker run -v $(pwd):/dotfiles -w /dotfiles --rm -it ubuntu bash -c "./install.sh && exec fish"
