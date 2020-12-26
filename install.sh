#! /usr/bin/env bash

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

export PATH="$HOME/.cargo/bin:$PATH"
cargo install bat exa loc bottom du-dust fd-find ripgrep starship

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

mkdir -p $HOME/.bin && \
for f in $DIR/bin/*; do if [[ -f $f ]]; then ln -sf $f $HOME/.bin; fi; done

mkdir -p $HOME/.fonts && \
for f in $DIR/fonts/*; do if [[ -f $f ]]; then ln -sf $f $HOME/.fonts; fi; done

mkdir -p $HOME/.config && \
for f in $DIR/config/*; do ln -sf $f $HOME/.config; done

mkdir -p $HOME/.zsh && \
for f in $DIR/zsh/*; do ln -sf $f $HOME/.zsh; done

ln -sf $DIR/.zshrc $HOME/

