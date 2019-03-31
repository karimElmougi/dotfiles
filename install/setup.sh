#! /usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
ln -sf $DIR/../.vimrc ~/
ln -sf $DIR/../.xinitrc ~/
ln -sf $DIR/../.zshrc ~/
ln -sf $DIR/../bin ~/
ln -sf $DIR/../compton.conf ~/.config/
ln -sf $DIR/../fontconfig ~/.config/
ln -sf $DIR/../ranger ~/.config/
ln -sf $DIR/../rofi ~/.config/

echo '%wheel ALL=NOPASSWD: /usr/bin/xbps-install -S' | sudo tee -a /etc/sudoers 
echo '%wheel ALL=NOPASSWD: /usr/bin/reboot' | sudo tee -a /etc/sudoers 
echo '%wheel ALL=NOPASSWD: /usr/bin/runit-init 0' | sudo tee -a /etc/sudoers 

cd ~/Pictures
wget https://i.imgur.com/HktehdS.png
wal -i HktehdS.png

