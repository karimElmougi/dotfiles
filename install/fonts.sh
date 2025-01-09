#! /usr/bin/env bash

echo "Installing nerd fonts"
if [[ `uname` != "Darwin" ]]; then
    echo "Only Mac OS is currently supported"
    exit 1
fi

set -x

cd ~/Library/Fonts

TAG=$(xh get https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | jq --raw-output '.tag_name')
URL="https://github.com/ryanoasis/nerd-fonts/releases/download/$TAG"

install() {
    mkdir $1 && cd $1 && xh --download $URL/$1.zip
    unzip $1.zip
    rm $1.zip
}

install Monaspace
# xh --download $URL/Iosevka.zip
# xh --download $URL/Inconsolata.zip
# xh --download $URL/Hack.zip
# xh --download $URL/FiraCode.zip
