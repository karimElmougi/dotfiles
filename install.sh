#! /usr/bin/env bash

DOTFILES=$(git rev-parse --show-toplevel)

git submodule update --init --recursive

if [[ `uname` == "Darwin" ]]; then
  $DOTFILES/install/brew.sh
  $DOTFILES/install/pkgin.sh
  /opt/homebrew/bin/brew bundle --file $DOTFILES/Brewfile
fi

$DOTFILES/install/packages.sh

$DOTFILES/install/rust.sh

$DOTFILES/install/cargo.sh

mkdir -p $HOME/.bin
mkdir -p $HOME/src

echo "Creating symbolic links to config files..."
mkdir -p $HOME/.config && \
for f in $DOTFILES/config/*; do ln -sf "$f" $HOME/.config; done

ln -sf $DOTFILES/gitconfig $HOME/.gitconfig

rm $HOME/.zshrc || true
ln -sf $DOTFILES/zshrc $HOME/.zshrc
ln -sf $DOTFILES/zsh $HOME/.zsh

$DOTFILES/install/fonts.sh
