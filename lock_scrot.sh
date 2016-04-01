#!/bin/sh
img=$(mktemp --suffix=.png)
scrot "$img"
i3lock -u -i "$img" -p default
