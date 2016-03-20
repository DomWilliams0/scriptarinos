#!/bin/sh
set -e

cd ~
echo Switched to $(pwd)

# automatic dotfiles
for f in dotfiles/.[^.]*
do
	if [ $f == "dotfiles/.git" ]; then continue; fi
	name=$(basename $f)
	ln -sfv ~/$f $name
done

mkdir -pv ~/.config
ln -sfv ~/dotfiles/i3 ~/.config
ln -sfv ~/dotfiles/i3blocks ~/.config
ln -sfv ~/dotfiles/redshift.conf ~/.config/redshift.conf
ln -sfv ~/dotfiles/aliases.zsh ~/.oh-my-zsh/custom/aliases.zsh
