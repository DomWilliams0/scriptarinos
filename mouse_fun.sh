#!/usr/bin/env bash
if (( $# != 2 )); then
	echo "Usage: $0 <variation> <wait>"
	exit 1
fi
MAX=$1
WAIT=$2
while true; do
	x=$(echo "$(shuf -i 0-$((MAX*2)) -n1)-$MAX"|bc)
	y=$(echo "$(shuf -i 0-$((MAX*2)) -n1)-$MAX"|bc)
	xdotool mousemove_relative -- $x $y
	sleep $(shuf -i0-"$WAIT" -n1)
done

