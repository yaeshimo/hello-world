#!/bin/sh
set -eu

counter=0

cinit() {
  counter=0
}
cadd() {
  counter=$(expr ${counter} + 1)
}
cout() {
  echo "${counter} loops"
}

main() {
  echo "-----\"\$*\"-----"
  cinit
  for x in "$*"; do
    echo "$x"
    cadd
  done
  cout

  echo "-----\$*-----"
  cinit
  for x in $*; do
    cadd
    echo "$x"
  done
  cout

  echo "-----\"\$@\"-----"
  cinit
  for x in "$@"; do
    cadd
    echo "$x"
  done
  cout

  echo "-----\$@-----"
  cinit
  for x in $@; do
    cadd
    echo "$x"
  done
  cout
}

[ "$#" -eq 0 ] &&
  main arg1 arg2 "arg3 arg4 arg5" arg6 ||
  main "$@"
