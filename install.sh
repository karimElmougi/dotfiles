#! /usr/bin/env bash

DOTFILES=$(git rev-parse --show-toplevel)

git submodule update --init --recursive

if [[ `uname` == "Darwin" ]]; then
  $DOTFILES/install/brew.sh
  $DOTFILES/install/pkgin.sh
  /opt/homebrew/bin/brew bundle --file $DOTFILES/Brewfile
fi

$DOTFILES/install/rust.sh

$DOTFILES/install/packages.sh

mkdir -p $HOME/.bin
mkdir -p $HOME/src

echo "Creating symbolic links to config files..."
mkdir -p $HOME/.config && \
for f in $DOTFILES/config/*; do ln -sf "$f" $HOME/.config; done

ln -sf $DOTFILES/gitconfig $HOME/.gitconfig

$DOTFILES/install/fonts.sh
