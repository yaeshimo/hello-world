#!/bin/sh
set -eu

confirm() {
  (
  key=""
  count=0
  while true; do
    [ $count -gt 3 ] && return 1
    count=$(( $count + 1 ))
    case "$key" in
      yes) return 0 ;;
      no) return 1 ;;
    esac
    echo -n "${1:-}"
    read key
  done
  )
}

confirm "input" && echo "true $?" || echo "false $?"

