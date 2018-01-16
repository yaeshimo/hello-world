#!/bin/bash
set -eu
hello="hello"

trimprefix="${hello#"he"}"
echo $trimprefix

trimsuffix="${hello%"lo"}"
echo $trimsuffix
