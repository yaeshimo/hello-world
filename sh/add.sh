#!/bin/sh
set -eu
set -o posix

a=10
b=20
res=$(( $a + $b ))

echo "$res"
