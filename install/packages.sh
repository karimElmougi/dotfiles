#! /usr/bin/env bash

DOTFILES=$(git rev-parse --show-toplevel)

if [[ `uname` == "Darwin" ]]; then
    INSTALL="sudo pkgin install -y"
elif [[ `uname` == "FreeBSD" ]]; then
    INSTALL="sudo pkg install -y"
else
  OS=`cat /etc/os-release | grep '^NAME' | sed 's/NAME="\(.*\)"/\1/'`
  if [[ $OS == "Fedora Linux" ]]; then
      INSTALL="sudo dnf install -y"
  elif [[ $OS == "Debian GNU/Linux" ]]; then
      INSTALL="sudo apt install -y"
  else
    echo "Script not configured for $OS, aborting"
    exit 1
  fi
fi

echo "Installing core packages"
$INSTALL git gh jq zsh
