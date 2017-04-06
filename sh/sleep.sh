#!/bin/sh
set -eu

echo "hi"
sleep 1 && echo "sleep 1" &
sleep 2 && echo "sleep 2" &
echo "hi"
wait
# EOF
