#!/bin/sh
set -eu
echo '$*'"=$*"
echo '$#'"=$#"
echo "----- SHIFT TEST -----"
for i in `seq 1 $#`; do
  echo "... $#"
  echo '$*='"$*"
  echo '$1='"$1"
  shift
done
echo "----- TEST END -----"
echo '$*='"$*"
echo '$#='"$#"
# EOF
