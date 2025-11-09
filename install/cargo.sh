#! /usr/bin/env bash

echo "Installing cargo packages"
export PATH="$HOME/.cargo/bin:$PATH"
cargo install atuin bat eza bottom du-dust fd-find ripgrep git-delta tealdeer tokei sd xh starship
