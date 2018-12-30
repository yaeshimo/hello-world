#!/bin/sh
set -eu

e() {
  (
  exit 2
  )
  echo "not display"
}

echo "e: $(e)"
echo "e: $?"

e2() {
  (
  exit $1
  )
}

e2 0
echo "e2: display"

# set -e
# e2 1
# echo "not display"

e3() {
  exit 0
}

e3
echo "e3: not display"

