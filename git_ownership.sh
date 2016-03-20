# Shows how many lines were touched by each user on every file, using git blame
#!/bin/sh
set -e

for f in `git ls-files | grep "java$"`; do
  echo `basename $f`
  git blame $f | awk -F'(' '{ print $2 }' | awk '{ print $1 }' | sort | uniq -c | sort -nr
  echo
done
