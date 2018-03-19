#!/bin/sh
set -eu

check_argv() {
	echo '--- $@ ---'
	echo "$@"
	echo 'for $@:'
	for x in $@; do echo -e "\t$x"; done
	echo 'for "$@":'
	for x in "$@"; do echo -e "\t$x"; done

	echo '--- $* ---'
	echo "$*"

	echo 'for $*'
	for x in $*; do echo -e "\t$x"; done
	echo 'for "$*":'
	for x in "$*"; do echo -e "\t$x"; done
}

check_argv arg1 arg2 arg3
