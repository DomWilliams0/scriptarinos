#!/usr/bin/env bash

if (($# < 4)); then
	echo "Usage: $0 <file> <output-file> <recipient|-d> <count> [gpg args...]"
	exit 1
fi


file="$1"
outfile="$2"
recp="$3"
n="$4"
gpg_args="${@:5}"

do_op() {
	if [[ "$recp" = "-d" ]]; then
		gpg --decrypt --yes -r $recp --output $2 $gpg_args $1
	else
		gpg --encrypt --sign --yes -r $recp --output $2 $gpg_args $1
	fi;

	n=$((n-1))
	echo "$1 => $2 | ($n) remaining"
}

input=$(mktemp)
output=$(mktemp)

do_op $file $input

while (($n > 0)); do
	do_op $input $output

	tmp=$input
	input=$output
	output=$tmp
done;

mv "$input" "$outfile"
rm -f "$input" "$output"
echo Output to "$outfile"
