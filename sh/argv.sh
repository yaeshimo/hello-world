#!/bin/sh
set -eu

main() {
  echo "-----\"\$*\"-----"
  for x in "$*"; do
    echo "$x"
  done

  echo "-----\$*-----"
  for x in $*; do
    echo "$x"
  done

  echo "-----\"\$@\"-----"
  for x in "$@"; do
    echo "$x"
  done

  echo "-----\$@-----"
  for x in $@; do
    echo "$x"
  done
}

[ "$#" -eq 0 ] &&
  main arg1 arg2 arg3 arg4 arg5 ||
  main "$@"
