#! /usr/bin/env bash

./xbps-install-list packages/fonts

sudo cp packages/icomoon.ttf /usr/share/fonts

sudo ln -s /usr/share/fontconfig/conf.avail/10-hinting-slight.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/10-scale-bitmap-fonts.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/20-unhint-small-vera.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/30-metric-aliases.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/40-nonlatin.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/45-latin.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/49-sansserif.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/50-user.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/51-local.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/60-latin.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/65-fonts-persian.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/65-nonlatin.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/69-unifont.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/80-delicious.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/90-synthetic.conf /etc/fonts/conf.d/
