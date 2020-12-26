#! /usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

for f in $DIR/dot/.*; do if [[ -f $f ]]; then ln -sf $f ~/; fi; done

ln -sf $DIR/config/* ~/.config/

