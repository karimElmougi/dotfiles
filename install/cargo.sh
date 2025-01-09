#! /usr/bin/env bash

echo "Installing cargo packages"
export PATH="$HOME/.cargo/bin:$PATH"
cargo install bat eza bottom du-dust fd-find ripgrep starship git-delta tealdeer tokei sd xh
