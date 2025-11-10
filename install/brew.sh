#! /usr/bin/env bash

if [[ `uname` == "Darwin" ]] && ! command -v brew > /dev/null 2>&1; then
    echo "Installing brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
