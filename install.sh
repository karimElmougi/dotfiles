#! /usr/bin/env bash

if !command -v git &> /dev/null then
  echo "git not installed!"
  exit 1
fi

if !command -v cargo &> /dev/null then
  echo "Cargo not installed!"
  exit 1
fi

if [[ `uname` == "Darwin" ]] && !command -v pkgin; then
    echo "pkgin not installed!"
    exit 1
fi

DIR=$(git rev-parse --show-toplevel)

if [ -d $HOME/.oh-my-zsh ]; then
  echo "oh-my-zsh is already installed, skipping"
else
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

export PATH="$HOME/.cargo/bin:$PATH"
cargo install bat exa bottom du-dust fd-find ripgrep starship git-delta tealdeer tokei sd

if [[ `uname` == "Darwin" ]]; then
  sudo pkgin install \
    git \
    gh \
    go \
    gopls \
    jq \
    tmux \
    the_silver_searcher \
    zsh-syntax-highlighting \
    zsh-autosuggestions
fi

mkdir -p $HOME/.bin

mkdir -p $HOME/.fonts && \
for f in $DIR/fonts/*; do if [[ -f $f ]]; then ln -sf "$f" $HOME/.fonts; fi; done

mkdir -p $HOME/.config && \
for f in $DIR/config/*; do ln -sf "$f" $HOME/.config; done

ln -sf $DIR/gitconfig $HOME/.gitconfig

rm $HOME/.zshrc || true
ln -sf $DIR/zshrc $HOME/.zshrc

