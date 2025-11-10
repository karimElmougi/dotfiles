#! /usr/bin/env bash

if [[ `uname` == "Darwin" ]]; then
    sudo pkgin update && sudo pkgin -y upgrade
    brew update && brew upgrade
    INSTALL="sudo pkgin install -y"
elif [[ `uname` == "FreeBSD" ]]; then
    sudo pkg update && sudo pkg upgrade -y
    INSTALL="sudo pkg install -y"
else
    OS=`cat /etc/os-release | grep '^NAME' | sed 's/NAME="\(.*\)"/\1/'`
    if [[ $OS == "Debian GNU/Linux" ]]; then
        sudo apt update && sudo apt upgrade -y
        INSTALL="sudo apt install -y"
    else
        echo "Script not configured for $OS, aborting"
        exit 1
    fi
fi

PKGS=(git gh jq)
BREW=()
CARGO=()

if [[ `uname` == "Darwin" ]]; then
    BREW+=(atuin bottom)
    PKGS+=(eza bat dust fd-find ripgrep git-delta tealdeer tokei sd xh starship)
    sudo ln -sf /opt/pkg/bin/{fdfind,fd}
elif [[ `uname` == "FreeBSD" ]]; then
    PKGS+=(zsh atuin bat eza bottom dust fd-find ripgrep git-delta tealdeer tokei sd xh starship)
else
    OS=`cat /etc/os-release | grep '^NAME' | sed 's/NAME="\(.*\)"/\1/'`
    if [[ $OS == "Debian GNU/Linux" ]]; then
        sudo ln -sf /opt/pkg/bin/{fdfind,fd}
        sudo ln -sf /opt/pkg/bin/{batcat,bat}
        PKGS+=(zsh atuin bat eza du-dust fd-find ripgrep git-delta tealdeer tokei sd xh)
        CARGO+=(bottom starship)
    else
        echo "Script not configured for $OS, aborting"
        exit 1
    fi
fi

echo "Installing core packages"
$INSTALL "${PKGS[@]}"

if [[ -n "${BREW[@]}" ]]; then
    echo "Installing brew packages"
    brew install "${BREW[@]}"
fi

if [[ -n "${CARGO[@]}" ]]; then
    echo "Installing cargo packages"
    export PATH="$HOME/.cargo/bin:$PATH"
    cargo install --locked "${CARGO[@]}"
fi
