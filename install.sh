#! /usr/bin/env bash

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

export PATH="$HOME/.cargo/bin:$PATH"
cargo install bat exa loc bottom du-dust fd-find ripgrep starship

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

for f in $DIR/dot/.*; do if [[ -f $f ]]; then ln -sf $f ~/; fi; done

ln -sf $DIR/config/* ~/.config/

ls -sf .zshrc ~/

