#!/usr/bin/env bash

set -ou pipefail
set -e

export GITHUB_HANDLE="juanrgon"

# destination for my personal scripts
export PERSONAL_SCRIPTS_DIR="$HOME/bin/$GITHUB_HANDLE"

# destination for my shortcuts
export SHORTCUTS_BIN="$HOME/shortcut/bin"

# directory of this script. NOTE: cd and pwd are used to get the absolute path, not the relative path.
THIS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_UPGRADE=1
export HOMEBREW_QUIET=1

main() {
    if [[ "${1:-}" == "--debug" ]]; then
        log "Debug mode enabled"
        set -x
    fi

    # Check for the flag to skip package installs
    for arg in "$@"; do
        if [[ "$arg" == "--skip-packages" ]]; then
            SKIP_PACKAGES=1
            log "Skipping package installation"
            break
        fi
    done

    if [[ -z "${SKIP_PACKAGES:-}" ]]; then
        log "💡 To skip package installation, run this script with the --skip-packages flag"
    fi

    ####################################################################
    # Install OS packages needed to start fish and install other packages
    ####################################################################
    if [[ -z "${SKIP_PACKAGES:-}" ]]; then
        log "Installing Essential OS packages..."
        install_packages \
            fish \
            rsync \
            git \
            curl
    else
        log "Essential OS packages installation skipped"
    fi

    ###########################################
    # Install homebrew if not already installed
    #
    # NOTE: requires git and curl on linux
    ###########################################
    install_homebrew

    ##############
    # Sync dotfiles
    ##############
    log "Syncing dotfiles..."
    rsync --recursive $THIS_DIR/dotfiles/ $HOME/  # WARNING: Never --delete here, or you'll delete your home directory

    ################################################
    # Copy personal scripts to $PERSONAL_SCRIPTS_DIR
    ################################################
    log "Importing personal scripts..."
    mkdir -p "$PERSONAL_SCRIPTS_DIR"                                        # Create personal scripts dir
    rsync --delete --recursive $THIS_DIR/scripts/* $PERSONAL_SCRIPTS_DIR    # Copy scripts to my personal scripts dir

    # Make personal scripts files executable
    chmod +x $PERSONAL_SCRIPTS_DIR/*;

    # Add personal scripts and shortcuts bin directories to $PATH
    export PATH="$PERSONAL_SCRIPTS_DIR:$PATH"
    export SHORTCUT_BIN="$SHORTCUTS_BIN:$PATH"

    #################################################################################
    # Add shortcuts
    #
    # They're like aliases, but they generate bash scripts, so they're shell agnostic
    #################################################################################
    log "Adding shortcuts..."
    shortcut copilot    'gh copilot suggest'
    shortcut d           docker
    shortcut dc          docker compose
    shortcut dcb         docker compose build
    shortcut dcdn        docker compose down
    shortcut dcr         docker compose run --rm
    shortcut dcup        docker compose up
    shortcut g           git
    shortcut ga          git add
    shortcut gapa        git add --patch
    shortcut gclean      git clean --force -d
    shortcut gcne        git commit --no-edit
    shortcut gd          git diff
    shortcut gdn         'git pull origin $(git_branch_name)'
    shortcut gdca        git diff --cached
    shortcut gf          git fetch --prune
    shortcut glg         git log --stat
    shortcut grbi        git rebase --interactive
    shortcut grh         git reset HEAD
    shortcut gs          git status
    shortcut gup         'git push origin $(git_branch_name)'

    if os_is_linux; then
        if command -v fdfind &> /dev/null; then
            log "Fixing fd for ubuntu..."
            shortcut fd fdfind
        fi

        if command -v batcat &> /dev/null; then
            log "Fixing bat for ubuntu..."
            shortcut bat batcat
        fi
    fi

    ##################
    # Setup git config
    ##################
    install_git_config $HOME/.config/git/$GITHUB_HANDLE.gitconfig

    ########################
    # Install extra packages
    ########################
    if [[ -z "${SKIP_PACKAGES:-}" ]]; then
        log "Installing Extra OS packages..."
        install_packages \
            tldr \
            ripgrep \
            fzf \
            hub \
            vim \
            git \
            htop \
            rsync \
            tree \
            fd \
            httpie \
            less

        install_openssl
        install_rust
        install_onepassword_cli
        install_awscli
    else
        log "Extra OS packages installation skipped"
    fi


    ###############################
    # Setup rust and cargo packages
    ###############################
    export PATH="$HOME/.cargo/bin:$PATH"
    if [[ -z "${SKIP_PACKAGES:-}" ]]; then
        log "Installing rust packages..."
        cargo install --locked \
            bat \
            exa \
            git-delta \
            chatgpt-cli \
            tokei || log "Warning: Failed to install rust packages"
    else
        log "Rust packages installation skipped"
    fi

    ##########################
    # Add git-delta git config
    ##########################
    install_git_config $HOME/.config/git/delta.gitconfig

    ###################################################################
    # Create shortcuts for rust alternatives to standard POSIX commands
    ###################################################################
    log "Adding rust cli alternative shortcuts..."
    if [ -x bat ]; then
        shortcut cat    bat
    fi

    if [ -x exa ]; then
        shortcut l      exa
        shortcut ll     exa --long --icons --group-directories-first --all
        shortcut lt     exa --tree
    fi

    #####################################
    # Install macos fonts for development
    #####################################
    if [[ -z "${SKIP_PACKAGES:-}" ]]; then
        macos_install_fonts
    else
        log "MacOS fonts installation skipped"
    fi

    ##############
    # Setup gh cli
    ##############
    if [[ -z "${SKIP_PACKAGES:-}" ]]; then
        setup_gh
    else
        log "gh cli installation skipped"
    fi

    ##############
    # Install node
    ##############
    if [[ -z "${SKIP_PACKAGES:-}" ]]; then
        install_node
    else
        log "Node installation skipped"
    fi

    ###############
    # Install pyenv
    ###############
    if [ -d $HOME/.pyenv ]; then
        log "pyenv already installed"
    else
        log "Installing pyenv..."
        curl https://pyenv.run | bash
    fi

    ##############
    # Install asdf
    ##############
    if [[ -z "${SKIP_PACKAGES:-}" ]]; then
        install_asdf
    else
        log "asdf installation skipped"
    fi

    ############
    # Install Go
    ############
    if [[ -z "${SKIP_PACKAGES:-}" ]]; then
        install_go
    else
        log "Go installation skipped"
    fi

    ############################
    # Add git-hooks to this repo
    ############################
    chmod +x $THIS_DIR/git-hooks/*
    rm -rf $THIS_DIR/.git/hooks/*
    mkdir -p $THIS_DIR/.git/hooks/
    cp $THIS_DIR/git-hooks/* $THIS_DIR/.git/hooks/

    #######################
    # Change MacOS settings
    #######################
    set_macos_settings
}

install_packages() {
    if [[ "${SKIP_PACKAGES:-}" == "1" ]]; then
        log "Skipping package installation"
        return
    fi

    PKGS=""
    for pkg in "$@"
    do
        PKGS="$PKGS $(package_name $pkg)"
    done

    if os_is_linux; then
        if user_is_root; then
            apt-get update
        else
            sudo apt-get update
        fi
        PKGS="$PKGS build-essential"
    elif os_is_macos; then
        # Make sure we have brew installed
        install_homebrew
    else
        log "FAILED TO INSTALL PACKAGES"
        log "OS not supported 😔: $OSTYPE"
        exit 1
    fi

    log installing $PKGS

    if os_is_linux; then
        if user_is_root; then
            apt-get install -y $PKGS
        else
            sudo apt-get install -y $PKGS
        fi
    elif os_is_macos; then
        # Make sure we have brew installed
        brew install --quiet --formula $PKGS
    else
        error "OS not supported 😔: $OSTYPE"
    fi
}

# Return the proper package name for the current OS
package_name() {
    case $1 in
        fd)
            if os_is_linux; then
                echo "fd-find"
            elif os_is_macos; then
                echo "fd"
            fi
            ;;
        cargo)
            if os_is_linux; then
                echo "cargo"
            elif os_is_macos; then
                echo "rust"
            fi
            ;;
        *)
            echo $1
            ;;
    esac
}

os_is_linux() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        return 0
    else
        return 1
    fi
}
export -f os_is_linux

os_is_macos() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        return 0
    else
        return 1
    fi
}
export -f os_is_macos

user_is_root() {
    if (( $EUID == 0 )); then
        return 0
    else
        return 1
    fi
}
export -f user_is_root

log() {
    echo "🏠 [dotfiles]: $*"
}
export -f log

error() {
    log "$* 😔"
}
export -f error

install_git_config() {
    GIT_CONFIG="$1"
    if git config --global --get-all include.path | grep "$GIT_CONFIG" > /dev/null; then
        log "$GIT_CONFIG already installed"
    else
        log "Setting up git config..."
        git config --global --add include.path $GIT_CONFIG
    fi
}
export -f install_git_config

function set_macos_settings() {
    if ! os_is_macos; then
        return
    fi

    log "Changing MacOS settings..."

    # Allow key repeat to work in all apps
    defaults write -g ApplePressAndHoldEnabled -bool false

    # Change the default photo save location to ~/Downloads
    defaults write com.apple.screencapture location -string "${HOME}/Downloads"

    # Disable the screenshot thumbnail
    defaults write com.apple.screencapture show-thumbnail -bool false

    # Faster dock hiding and unhiding
    defaults write com.apple.dock autohide-delay -float 0; defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock

    # Make hidden apps visible in the dock
    defaults write com.apple.Dock showhidden -bool TRUE && killall Dock

    # Change the default finder folder to ~/Downloads
    defaults write com.apple.finder NewWindowTarget -string "PfLo"
}

function macos_install_fonts() {
    log "Installing fonts..."

    if ! os_is_macos; then
        return
    fi

    brew install --cask \
        font-fira-code-nerd-font \
        font-hasklug-nerd-font
}

function install_onepassword_cli() {
    if os_is_macos; then
        brew install --cask 1password/tap/1password-cli
        shortcut opaws 'op plugin run -- aws'
    fi
}

function setup_gh() {
    # TODO: Support other OSes
    if ! os_is_macos; then
        return
    fi

    log "Setting up gh cli..."
    brew install gh

    # Login to gh if not already logged in
    if ! gh auth status &> /dev/null; then
        log "Logging into gh cli..."
        gh auth login
    fi
}

function install_awscli() {
    if os_is_macos; then
        brew install awscli
    fi
}

function install_node() {
    # Skip if node is already installed
    if command -v node &> /dev/null; then
        log "node already installed"
        return
    fi

    log "Installing node..."

    # TODO: Support other OSes
    if ! os_is_macos; then
        install_packages nodejs
        return
    fi

    curl -L https://bit.ly/n-install | bash -s -- -y
}

function install_openssl() {
    if os_is_linux; then
        log "Installing openssl..."
        install_packages \
            openssl \
            libssl-dev
    fi
}

function install_rust() {
    if command -v rustup &> /dev/null; then
        return
    fi

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    log "rustup already installed"
}

function install_ruby() {
    if command -v rbenv &> /dev/null; then
        return
    fi

    log "Installing rbenv..."

    if os_is_linux; then
        install_packages \
            rbenv
    elif os_is_macos; then
        brew install rbenv ruby-build
    fi
}

function install_homebrew() {
    if ! command -v brew &> /dev/null; then
        log "Installing Homebrew..."
        echo | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        export PATH="/opt/homebrew/sbin:/opt/homebrew/bin:$PATH"
    fi

    if os_is_linux; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
}

function install_asdf() {
    if ! command -v asdf &> /dev/null; then
        log "Installing asdf..."
        if os_is_macos; then
            brew install asdf
        elif os_is_linux; then
            # TODO: need to install asdf on Linux
            echo "⚠️ Skipping asdf installation on Linux"
        fi
    fi
}

function install_go() {
    if ! command -v go &> /dev/null; then
        log "Installing Go..."
        if ! command -v asdf &> /dev/null; then
            log "asdf required to install go"
            return
        fi

        asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
        asdf install -u golang latest
    fi

    if ! command -v golangci-lint &> /dev/null; then
        log "installing golangci-lint..."
        curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/HEAD/install.sh | sh -s -- -b $(go env GOPATH)/bin v2.4.0
    fi

    if ! command -v dlv &> /dev/null; then
        log "Installing delve..."
        go install github.com/go-delve/delve/cmd/dlv@latest
    fi

    if ! command -v gopls &> /dev/null; then
        log "Installing gopls..."
        go install golang.org/x/tools/gopls@latest
    fi
}

main $*
