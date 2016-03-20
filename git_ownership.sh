# Shows how many lines were touched by each user on every file, using git blame
#!/bin/sh
set -e

for f in `git ls-files | grep "java$"`; do
  echo `basename $f`
  git blame --minimal --line-porcelain -w $f | pcregrep -o1 "^author\s(.+)$" | sort | uniq -c | sort -nr
  echo
done
