# Shows how many lines were touched by each user on every file, using git blame
#!/bin/sh
set -e

full_name=false

while getopts "f" opt; do
  case $opt in
    f)
      full_name=true
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
