#! /usr/bin/env bash

ln -s $(pwd)/.vimrc ~/
ln -s $(pwd)/.xinitrc ~/
ln -s $(pwd)/.zshrc ~/
ln -s $(pwd)/bin ~/
ln -s $(pwd)/compton.conf ~/.config/
ln -s $(pwd)/fontconfig ~/.config/
ln -s $(pwd)/i3 ~/.config/
ln -s $(pwd)/polybar ~/.config/
ln -s $(pwd)/ranger ~/.config/
ln -s $(pwd)/rofi ~/.config/
ln -s $(pwd)/termite ~/.config/

echo '%wheel ALL=NOPASSWD: /usr/bin/xbps-install -S' | sudo tee -a /etc/sudoers 
