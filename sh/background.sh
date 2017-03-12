#!/bin/sh
set -eu

# to background
sleep 5 && echo "wait for me!" &

# $1=PID
wait $!

# EOF
