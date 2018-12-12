#!/bin/sh
case "$1" in
  "")
    echo "\"\""
    ;;
  test*)
    printf "test*: %s\n\$*: %s\n" "$1" "$*"
    ;;
  *)
    echo "\$*: $*"
    ;;
esac
