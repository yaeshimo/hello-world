#!/bin/sh

# output contents of process
#set -x
#set -o xtrace

# append script contents to output
#set -v
#set -verbose

# script check, not run
#set -n
#set -o noexec

# if error then, exit
set -e
#set -o errexit

# if use undefined variable then, exit
set -u
#set -o nounset

# redirect stopper for reject override
set -C
#set -o noclobber
if false; then
  scriptdir="$(dirname "$0")"
  echo "test" > "$scriptdir"/test.log # if file exists then, error
  echo "test" >| "$scriptdir"/test.log # accept override
  echo "test" >> "$scriptdir"/test.log # none error
  cat "$scriptdir"/test.log
fi

# don't read symlink
#set -P
#set -o physical

var="hi"
echo $var

readonly var="hello"
echo $var
#var="wrold" # error
#unset var # error

var2="world!"
echo "$var2"

unset var2
#echo "vanish: >> $var2" # error

say() {
  var3="say hello" # default local
  echo "$var3"
}
#echo "not found >> $var3" # error
say
unset -f say
#say # error

# EOF
