#!/bin/sh
set -eu

sub() {
  (
  echo "$(( 20 + 30 ))"
  )
}

ex() {
  (
  expr 2 + 3
  expr 812 \* 5
  )
}

echo "sub: $(sub)"

echo "ex: $(ex)"

