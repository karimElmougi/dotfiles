#! /usr/bin/env bash

echo "Installing nerd fonts"
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts
cd nerd-fonts \
  && ./install.sh Iosevka \
  && ./install.sh Inconsolata \
  && ./install.sh Hack \
  && ./install.sh FiraCode \
  && ./install.sh Monaspace \
  && cd ..
