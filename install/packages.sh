#! /usr/bin/env bash

if [[ `uname` == "Darwin" ]]; then
    sudo pkgin update && sudo pkgin -y upgrade
    brew update && brew upgrade
    INSTALL="sudo pkgin -y install"
elif [[ `uname` == "FreeBSD" ]]; then
    sudo pkg update && sudo pkg upgrade -y
    INSTALL="sudo pkg install -y"
else
    OS=`cat /etc/os-release | grep '^NAME' | sed 's/NAME="\(.*\)"/\1/'`
    if [[ $OS == "Debian GNU/Linux" ]]; then
        sudo apt update && sudo apt upgrade -y
        INSTALL="sudo apt install -y"
    elif [[ $OS == "Void" ]]; then
	sudo xbps-install -Syu
        INSTALL="sudo xbps-install -y"
    else
        echo "Script not configured for $OS, aborting"
        exit 1
    fi
fi

PKGS=(git jq)
BREW=()
CARGO=()

if [[ `uname` == "Darwin" ]]; then
    BREW+=(atuin bottom)
    PKGS+=(gh eza bat dust fd-find jj ripgrep git-delta tealdeer tokei sd xh)
    sudo ln -sf /opt/pkg/bin/{fdfind,fd}
elif [[ `uname` == "FreeBSD" ]]; then
    PKGS+=(gh zsh atuin bat eza bottom dust fd-find jujutsu ripgrep git-delta tealdeer tokei sd xh)
else
    OS=`cat /etc/os-release | grep '^NAME' | sed 's/NAME="\(.*\)"/\1/'`
    if [[ $OS == "Debian GNU/Linux" ]]; then
        sudo ln -sf /opt/pkg/bin/{fdfind,fd}
        sudo ln -sf /opt/pkg/bin/{batcat,bat}
        PKGS+=(gh zsh atuin bat eza du-dust fd-find ripgrep git-delta tealdeer tokei sd xh)
        CARGO+=(bottom jj)
    elif [[ $OS == "Void" ]]; then
	PKGS+=(github-cli fd bat atuin eza dust ripgrep delta tealdeer tokei sd xh bottom jujutsu fish-shell)
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
