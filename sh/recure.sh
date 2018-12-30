#!/bin/sh
set -eu

echo_dirs() {
  (
  d="$(readlink -e "$1")"
  [ -d "$d" ] || return

  c=0
  for x in "$d"/*; do
    [ -d "$x" ] && echo "$c: $x"
    c=$(( c + 1 ))
  done

  for x in "$d"/*; do
    if [ -d "$x" ]; then
      echo_dirs "$x"
    fi
  done
  )
}

echo_dirs "$1"

