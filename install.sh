#!/usr/bin/env bash

set -ou pipefail
set -e

# destination for my personal scripts
PERSONAL_SCRIPTS_DIR="$HOME/bin/juanrgon"

# directory of this script. NOTE: cd and pwd are used to get the absolute path, not the relative path.
THIS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

main() {
    ####################################################################
    # Install OS packages needed to start fish and install other packages
    ####################################################################
    log "Installing Essential OS packages..."
    install_packages \
        fish \
        rsync \
        git \
        curl

    ##############
    # Sync dotfiles
    ##############
    log "Syncing dotfiles..."
    rsync $THIS_DIR/dotfiles/ $HOME/ -r

    ################################################
    # Copy personal scripts to $PERSONAL_SCRIPTS_DIR
    ################################################
    log "Importing personal scripts..."
    mkdir -p "$PERSONAL_SCRIPTS_DIR"                         # Create personal scripts dir
    cp $THIS_DIR/scripts/* $PERSONAL_SCRIPTS_DIR             # Copy scripts to my personal scripts dir

    # Make personal scripts files executable
    for SCRIPT in $PERSONAL_SCRIPTS_DIR/*;
    do
        if [ -f $SCRIPT ]; then
            chmod +x $SCRIPT
        fi
    done

    #################################################################################
    # Add shortcuts
    #
    # They're like aliases, but they generate bash scripts, so they're shell agnostic
    #################################################################################
    log "Adding shortcuts..."
    shortcut cat    bat
    shortcut d      docker
    shortcut dc     docker compose
    shortcut dcb    docker compose build
    shortcut dcdn   docker compose down
    shortcut dcr    docker compose run --rm
    shortcut dcup   docker compose up
    shortcut dfr    "cd $THIS_DIR && gdn && $THIS_DIR/install.sh"
    shortcut g      git
    shortcut ga     git add
    shortcut gapa   git add --patch
    shortcut gclean git clean --force -d
    shortcut gcne   git commit --no-edit
    shortcut gco    git checkout
    shortcut gcom   'git checkout $(git_main_branch_name)'
    shortcut gd     git diff
    shortcut gdn    'git pull origin $(git_branch_name)'
    shortcut gdca   git diff --cached
    shortcut gf     git fetch --prune
    shortcut glg    git log --stat
    shortcut gnb    git checkout -b
    shortcut grbi   git rebase --interactive
    shortcut grh    git reset HEAD
    shortcut gs     git status
    shortcut gup    'git push origin $(git_branch_name)'
    shortcut ls     exa
    shortcut l      ls
    shortcut ll     ls --long --icons --group-directories-first --all
    shortcut lt     ls --tree

    if os_is_linux; then
        if command -v fdfind &> /dev/null; then
            log "Fixing fd for ubuntu..."
            shortcut fd fdfind
        fi

        if command -v batcat &> /dev/null; then
            shortcut bat batcat
        fi
    fi

    #################
    # Setup git config
    #################
    GIT_CONFIG=$HOME/.config/git/juanrgon.gitconfig
    if git config --global --get-all include.path | grep $GIT_CONFIG > /dev/null; then
        log "gitconfig already set up"
    else
        log "Setting up git config..."
        git config --global --add include.path $GIT_CONFIG
    fi

    # If vscode is installed, make it the default git editor
    if command -v code &> /dev/null; then
        git config --global core.editor "code --wait"
    fi

    ########################
    # Install extra packages
    ########################
    log "Installing Extra OS packages..."
    install_packages \
        tldr \
        ripgrep \
        fzf \
        hub \
        vim \
        git \
        htop \
        bat \
        rsync \
        tree \
        exa \
        fd \
        cargo \
        httpie \
        less

    ###############################
    # Setup rust and cargo packages
    ###############################
    export PATH="$HOME/.cargo/bin:$PATH"
    log "Installing rust packages..."
    cargo install \
        git-delta
}

install_packages() {
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
        if ! command -v brew &> /dev/null; then
            log "Installing Homebrew..."
            $THIS_DIR/install/homebrew.sh
        fi
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
        brew install $@
    else
        error "OS not supported 😔: $OSTYPE"
    fi
}

# Return the proper package name for the current OS
package_name() {
    if [ $1 == "fd" ]; then
        if os_is_linux; then
            echo "fd-find"
        elif os_is_macos; then
            echo "fd"
        fi
    else
        echo $1
    fi
}

os_is_linux() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        return 0
    else
        return 1
    fi
}

os_is_macos() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        return 0
    else
        return 1
    fi
}

user_is_root() {
    if (( $EUID == 0 )); then
        return 0
    else
        return 1
    fi
}

make_fish_default_shell() {
    FISH_PATH=$(which fish)

    if ! grep -q fish /etc/shells; then
        if user_is_root; then
            echo $FISH_PATH >> /etc/shells
        else
            echo $FISH_PATH | sudo tee -a /etc/shells
        fi
    fi

    log "Setting fish as default shell..."
    chsh -s $FISH_PATH
}

log() {
    echo "🏠 [dotfiles]: $*"
}

error() {
    log "$* 😔"
}

shortcut() {
    SHORTCUT_NAME=$1
    shift

/bin/cat << EOF > $PERSONAL_SCRIPTS_DIR/$SHORTCUT_NAME
#!/usr/bin/env bash
$* \$*
EOF

chmod +x $PERSONAL_SCRIPTS_DIR/$SHORTCUT_NAME
}


main
