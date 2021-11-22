#! /usr/bin/env bash

DIR=$(git rev-parse --show-toplevel)

mkdir -p $HOME/.fonts && \
for f in $DIR/fonts/*; do if [[ -f $f ]]; then ln -sf "$f" $HOME/.fonts; fi; done

mkdir -p $HOME/.config && \
for f in $DIR/config/*; do ln -sf "$f" $HOME/.config; done

if [[ "$OSTYPE" == "darwin*" ]]; then
  ln -sf $DIR/pkgs.nix $HOME/.nixpkgs/darwin-configuration.nix
fi

ln -sf $DIR/gitconfig $HOME/.gitconfig

rm $HOME/.zshrc || true
ln -sf $DIR/zshrc $HOME/.zshrc

