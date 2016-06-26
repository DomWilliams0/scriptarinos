#!/usr/bin/env bash

ROOT="$HOME/.dropbox-encrypted"
DROPBOX_DIR="$ROOT/Dropbox"
CONTAINER_PATH="$ROOT/container"
SYNCED_CONTAINER_PATH="$DROPBOX_DIR/container"
MOUNT="$HOME/dropbox-container"

HOME=$ROOT

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

	mkdir -p -- $ROOT
	/usr/bin/dropbox-cli start -i
}

container_exists() {
	[ -f $CONTAINER_PATH ]
}

container_synced() {
	grep ": up to date$" <(dropbox-cli filestatus $SYNCED_CONTAINER_PATH) 1>/dev/null 2>&1
}

create_container() {
	# TODO create
	# this is just all todos so far isnt it
	echo creating
	:
}

# returns 0 if synced and ready to use, otherwise 1
prepare_container() {

	if container_exists; then
		container_synced || return 1
	else
		create_container
	fi
}

# exits with failure if container is not yet ready/synced
wait_for_container() {
	prepare_container || exit 1 # not ready yet
}

do_mount() {
	wait_for_container

	# create container if doesn't already exist
	#	create sparse dd
	#	create loopback device
	#	encrypt with cryptsetup
	#	create fs
	# otherwise sync with dropbox
	#	wait for dropbox to finish syncing it
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
