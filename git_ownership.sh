#!/bin/sh
# Shows how many lines were touched by each user on every file in a git repository, using git blame

# Parameters:
# -f        Print full file paths 
# -r regex  File regex           

set -e

full_name=false
file_regex=""

while getopts ":fr:" opt; do
  case $opt in
    f)
      full_name=true
      ;;
    r)
      file_regex="$OPTARG"
      ;;
    :)
      echo "Parameter required for -$OPTARG"
      exit 1
      ;;
    \?)
      echo "Invalid parameter: -$OPTARG"
      exit 1
      ;;
  esac
done

for f in `git ls-files | grep "$file_regex"`; do
  if [ "$full_name" = true ]; then
    echo "$f"
  else
    echo `basename $f`
  fi

  git blame --minimal --line-porcelain -w $f | pcregrep -o1 "^author\s(.+)$" | sort | uniq -c | sort -nr
  echo
done
