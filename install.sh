#! /usr/bin/env bash

if ! command -v git &> /dev/null 
then
  echo "git not installed!"
  exit 1
fi

if ! command -v cargo &> /dev/null 
then
  echo "Cargo not installed!"
  exit 1
fi

if [[ `uname` == "Darwin" ]]; 
then
  if ! command -v pkgin; 
  then
    echo "pkgin not installed!"
    exit 1
  fi
  if ! command -v brew; 
  then
    echo "brew not installed!"
    exit 1
  fi
else
  echo "Script not configured for OS, aborting"
  exit 1
fi

DOTFILES=$(git rev-parse --show-toplevel)

if [ -d $HOME/.oh-my-zsh ]; 
then
  echo "oh-my-zsh is already installed, skipping"
else
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

export PATH="$HOME/.cargo/bin:$PATH"
cargo install bat exa bottom du-dust fd-find ripgrep starship git-delta tealdeer tokei sd

if [[ `uname` == "Darwin" ]]; 
then
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
  brew bundle --file $DOTFILES/Brewfile
fi

mkdir -p $HOME/.bin

echo "Installing fonts..."
mkdir -p $HOME/.fonts && \
for f in $DOTFILES/fonts/*; do if [[ -f $f ]]; then ln -sf "$f" $HOME/.fonts; fi; done

echo "Creating symbolic links to config files..."
mkdir -p $HOME/.config && \
for f in $DOTFILES/config/*; do ln -sf "$f" $HOME/.config; done

ln -sf $DOTFILES/gitconfig $HOME/.gitconfig

ln -sf $DOTFILES/tmux.conf $HOME/.tmux.conf

rm $HOME/.zshrc || true
ln -sf $DOTFILES/zshrc $HOME/.zshrc

