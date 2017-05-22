#!/bin/sh
set -eu

line1="$(ls | \
  grep line)"

line2="$(ls |
  grep line)"

echo $line1
echo $line2

# EOF
