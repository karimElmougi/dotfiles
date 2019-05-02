#! /usr/bin/env bash

./xbps-install-list packages/base_system && \
xdg-user-dirs-update && \
chsh -s /bin/zsh && \
git config --global user.email "karim.elmougi@gmail.com" && \
git config --global user.name "karim" && \
sudo reboot

