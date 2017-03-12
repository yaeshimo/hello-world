#!/bin/sh

set -eu

echo "--- say ---"
say() {
  echo "hi!"
}
say
# same and override
function say() {
  echo "hello!"
}
say
type say

echo "--- param ---"
param() {
  cat <<END
param
  PID   $$
  set   $-
  path  $0
  argc  $#
  argv  $@
  argv  $*
  arg1  $1
  arg2  $2
  arg2  $3
END
  echo
  echo '"$*"' # "$1 $2 $2"
  for i in "$*"; do
    echo $i
  done
  echo '"$@"' # "$1" "$2" "$3"
  for i in "$@"; do
    echo $i
  done
  echo
}
param hi hello world

echo $0
echo "word count=${#0}" # word count

# EOF
