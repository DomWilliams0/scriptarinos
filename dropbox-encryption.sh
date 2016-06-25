#!/usr/bin/env bash

DROPBOX_DIR="$HOME/.dropbox-encrypted"
MOUNT="$HOME/dropbox-container"

# TODO
# keep container outside of Dropbox
# sync with rsync from container into dropbox
# use notify-send

do_setup() {
	# already exists
	if [[ -d $DROPBOX_DIR ]]; then
		echo "Already setup at '$DROPBOX_DIR'"
		exit 0
	fi

	mkdir -p -- $DROPBOX_DIR
	HOME=$DROPBOX_DIR
	/usr/bin/dropbox-cli start -i
}

do_mount() {
	echo mount
	exit 2

	# create container if doesn't already exist
	#	create sparse dd
	#	create loopback device
	#	encrypt with cryptsetup
	#	create fs
	# create loopback device
	# mount in $MOUNT
}

do_unmount() {
	echo unmount
	exit 2

	# ensure already mounted at $MOUNT
	# unmount
	# delete loopback device
	# luksClose
	# rsync into dropbox directory
}

print_usage() {
	echo "Usage: $0 <setup | mount | unmount>"
	exit 1
}

[[ "$#" != "1" ]] && print_usage

case "$1" in
	"setup")
		do_setup
		;;
	"mount")
		do_mount
		;;
	"unmount")
		do_unmount
		;;
	*)
		print_usage
		;;
esac
