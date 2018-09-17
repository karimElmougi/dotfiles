#! /usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
ln -s $DIR/../.vimrc ~/
ln -s $DIR/../.xinitrc ~/
ln -s $DIR/../.zshrc ~/
ln -s $DIR/../bin ~/
ln -s $DIR/../compton.conf ~/.config/
ln -s $DIR/../fontconfig ~/.config/
ln -s $DIR/../i3 ~/.config/
ln -s $DIR/../polybar ~/.config/
ln -s $DIR/../ranger ~/.config/
ln -s $DIR/../rofi ~/.config/
ln -s $DIR/../termite ~/.config/
ln -s $DIR/../networkmanager-dmenu ~/.config/

sudo cp $DIR/50-org.freedesktop.NetworkManager.rules /etc/polkit-1/rules.d/
sudo gpasswd -a $USER network

echo '%wheel ALL=NOPASSWD: /usr/bin/xbps-install -S' | sudo tee -a /etc/sudoers 
echo '%wheel ALL=NOPASSWD: /usr/bin/reboot' | sudo tee -a /etc/sudoers 
echo '%wheel ALL=NOPASSWD: /usr/bin/runit-init 0' | sudo tee -a /etc/sudoers 

cat $DIR/70-synaptics.conf | sudo tee -a /usr/share/X11/xorg.conf.d/70-synaptics.conf

cd ~/Pictures
wget https://i.imgur.com/HktehdS.png
wal -i HktehdS.png
