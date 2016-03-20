#!/bin/sh
# Shows how many lines were touched by each user on every file in a git repository, using git blame

# Parameters:
# -f      Print full file paths

set -e

full_name=false

while getopts ":f" opt; do
  case $opt in
    f)
      full_name=true
      ;;
    \?)
      echo "Invalid parameter: -$OPTARG"
      exit 1
      ;;
  esac
done

for f in `git ls-files | grep "java$"`; do
  if [ "$full_name" = true ]; then
    echo "$f"
  else
    echo `basename $f`
  fi

  git blame --minimal --line-porcelain -w $f | pcregrep -o1 "^author\s(.+)$" | sort | uniq -c | sort -nr
  echo
done
