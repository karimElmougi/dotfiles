#! /usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
for f in $DIR/dot/.*; do if [[ -f $f ]]; then ln -sf $f ~/; fi; done
ln -sf $DIR/bin ~/
ln -sf $DIR/config/* ~/.config/

echo '%wheel ALL=NOPASSWD: /usr/bin/xbps-install -S' | sudo tee -a /etc/sudoers 
echo '%wheel ALL=NOPASSWD: /usr/bin/reboot' | sudo tee -a /etc/sudoers 
echo '%wheel ALL=NOPASSWD: /usr/bin/runit-init 0' | sudo tee -a /etc/sudoers 

cd ~/Pictures
wget https://i.imgur.com/HktehdS.png
feh --bg-fill ~/Pictures/HktehdS.png

