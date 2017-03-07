#!/bin/sh

set -eu

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

param() {
  cat <<END
param
  path  $0
  argc  $#
  argv  $@
  argv  $*
  arg1  $1
  arg2  $2
  arg2  $3
END
}
param hi hello world
