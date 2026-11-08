#!/usr/bin/env bash

# Use this script to test installing dotfiles in a fresh Linux docker container.
#
# Usage: ./test.sh [ubuntu|arch]   (default: ubuntu)
#
# The repo is mounted read-only and copied inside the container, so the test
# never writes to this checkout.

set -euo pipefail

SETUP="true"
case "${1:-ubuntu}" in
    ubuntu) IMAGE=ubuntu ;;
    arch)
        IMAGE=archlinux
        # pacman's download sandbox fails under amd64 emulation (e.g. on Apple Silicon)
        SETUP="sed -i -e '/^\[options\]/a DisableSandbox' -e 's/^DownloadUser/#DownloadUser/' /etc/pacman.conf"
        ;;
    *)
        echo "Usage: $0 [ubuntu|arch]"
        exit 1
        ;;
esac

docker run --platform linux/amd64 -v "$(pwd)":/src:ro --rm -it "$IMAGE" \
    bash -c "$SETUP && cp -r /src /dotfiles && rm -rf /dotfiles/.git && cd /dotfiles && ./install.sh && exec fish"
