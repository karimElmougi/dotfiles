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
ln -s $(pwd)/networkmanager-dmenu ~/.config/

sudo cp install/50-org.freedesktop.NetworkManager.rules /etc/polkit-1/rules.d/
sudo gpasswd -a $USER network

echo '%wheel ALL=NOPASSWD: /usr/bin/xbps-install -S' | sudo tee -a /etc/sudoers 
echo '%wheel ALL=NOPASSWD: /usr/bin/reboot' | sudo tee -a /etc/sudoers 
echo '%wheel ALL=NOPASSWD: /usr/bin/runit-init 0' | sudo tee -a /etc/sudoers 

cd ~/Pictures
wget https://i.imgur.com/HktehdS.png
wal -i HktehdS.png
