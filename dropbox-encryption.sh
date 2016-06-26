#!/usr/bin/env bash

ROOT="$HOME/.dropbox-encrypted"
DROPBOX_DIR="$ROOT/Dropbox"
CONTAINER_PATH="$ROOT/container"
SYNCED_CONTAINER_PATH="$DROPBOX_DIR/container"
MOUNT="$HOME/dropbox-container"

CONTAINER_SIZE="1G"
CONTAINER_DEVICE="dropbox-encrypted-$(whoami)"
CONTAINER_DEVICE_MAPPED=/dev/mapper/$CONTAINER_DEVICE

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
	set -e

	echo Creating sparse container of size $CONTAINER_SIZE
	dd if=/dev/zero of=$CONTAINER_PATH bs=1 count=0 seek=1G

	echo Creating LUKS container
	sudo cryptsetup -y luksFormat $CONTAINER_PATH

	mount_container

	echo Creating filesystem
	sudo mkfs.ext4 $CONTAINER_DEVICE_MAPPED

	set +e
}

mount_container() {
	set -e

	if ! grep "is active." <(sudo cryptsetup status $CONTAINER_DEVICE_MAPPED); then
		echo Unlocking container
		sudo cryptsetup luksOpen $CONTAINER_PATH $CONTAINER_DEVICE
	fi

	if ! grep $MOUNT <(mount); then
		echo Mounting volume
		mkdir -p -- $MOUNT
		sudo mount $CONTAINER_DEVICE_MAPPED $MOUNT
		sudo chown $(whoami) $MOUNT
	fi

	set +e
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
	if ! prepare_container; then
		echo The container is not ready yet
		exit 1
	fi
}

do_mount() {
	wait_for_container
	mount_container

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
