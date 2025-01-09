#! /usr/bin/env bash


if [[ `uname` == "Darwin" ]] && ! command -v brew; then
    echo "Installing brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
