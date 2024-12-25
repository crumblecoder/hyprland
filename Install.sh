#!/bin/bash
sudo xbps-install -Sy wget fzf parted
wget -qO- https://raw.githubusercontent.com/crumblecoder/hyprland/main/.void-installer.conf > /tmp/.void-installer.conf
wget -qO- https://raw.githubusercontent.com/crumblecoder/hyprland/refs/heads/main/CreateDiskPartition > ~/CreateDiskPartition.sh
lsblk -dpn
echo "cambio"
cat ~/CreateDiskPartition.sh| sudo bash
