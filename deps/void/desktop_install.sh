#! /usr/bin/env bash

./xbps-install-list packages/desktop && \
sudo ln -s /etc/sv/dbus /var/service/ && \
sudo ln -s /etc/sv/alsa /var/service/

sudo reboot

