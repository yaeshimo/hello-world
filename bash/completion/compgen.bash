#!/bin/bash
set -eu

echo "compgen -W \"hello world\""
compgen -W "hello world"
echo "compgen -W \"hello world\" -- h"
compgen -W "hello world" -- h
