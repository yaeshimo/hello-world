#!/bin/sh

set -eu

for x in *; do
  echo "$x"
done

echo
for x in {0..10};do echo $x; done

echo
for x in {10..256..32};do echo $x; done

echo
for x in {a..n};do echo $x; done
