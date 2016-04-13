#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo Must be root
	exit 1
fi

pacman -S zsh
./install_yaourt.sh

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

sh -c "$(wget https://raw.githubusercontent.com/DomWilliams0/wallpaper-fetcher/master/install.sh -O -)"

pacman-key --recv-keys AE6866C7962DDE58 962DDE58
pacman-key --lsign-key 962DDE58
echo -e "[infinality-bundle]\nServer = http://bohoomil.com/repo/\$arch" >> /etc/pacman.conf
echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
pacman -Syyu
pacman -S infinality-bundle
pacman-key --refresh-keys

mkdir ~/screenshots

pacman -R vi
systemctl enable --now NetworkManager.service

mkdir ~/Pictures
wget https://wallpapers.wallhaven.cc/wallpapers/full/wallhaven-268242.jpg -O ~/Pictures/wallpaper.jpg
