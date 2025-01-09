#! /usr/bin/env bash

DOTFILES=$(git rev-parse --show-toplevel)

git submodule update --init --recursive

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
elif [[ `uname` == "FreeBSD" ]];
then
	echo "Detected FreeBSD..."
else
  OS=`cat /etc/os-release | grep '^NAME' | sed 's/NAME="\(.*\)"/\1/'`
  if [[ $OS == "Fedora Linux" ]];
  then
	echo "Detected Fedora..."
  else
    echo "Script not configured for $OS, aborting"
    exit 1
  fi
fi

if [[ `uname` == "Darwin" ]]; 
then
  sudo pkgin install \
    git \
    gh \
    jq
  brew bundle --file $DOTFILES/Brewfile
fi

if [[ `uname` == "Linux" ]]; 
then
  sudo dnf install \
    git \
    gh \
    jq \
    zsh
fi

export PATH="$HOME/.cargo/bin:$PATH"
cargo install bat eza bottom du-dust fd-find ripgrep starship git-delta tealdeer tokei sd

if [[ `uname` == "FreeBSD" ]]; 
then
  sudo pkg install \
    git \
    gh \
    jq \
    zsh
fi

mkdir -p $HOME/.bin

echo "Creating symbolic links to config files..."
mkdir -p $HOME/.config && \
for f in $DOTFILES/config/*; do ln -sf "$f" $HOME/.config; done

ln -sf $DOTFILES/gitconfig $HOME/.gitconfig

rm $HOME/.zshrc || true
ln -sf $DOTFILES/zshrc $HOME/.zshrc
ln -sf $DOTFILES/zsh $HOME/.zsh

echo "Installing fonts..."
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts
cd nerd-fonts \
  && ./install.sh Iosevka \
  && ./install.sh Inconsolata \
  && ./install.sh Hack \
  && ./install.sh FiraCode \
  && cd ..
