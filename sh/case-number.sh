#!/bin/sh
set -eu

case "$1" in
  ''|*[!0-9]*) echo "not number \"$*\"";;
  *) echo "number \"$1\"";;
esac

