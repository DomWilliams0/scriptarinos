#!/bin/bash
mkdir -p "$HOME/Pictures"
wget https://wallpapers.wallhaven.cc/wallpapers/full/wallhaven-268242.jpg -O "$HOME/Pictures/wallpaper.jpg"
feh --bg-fill "$HOME/Pictures/wallpaper.jpg"
