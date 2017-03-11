#!/bin/sh
set -eu
for i in `seq 1 $#`; do
  echo $1
  shift
done
# EOF
