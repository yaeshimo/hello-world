#!/bin/sh

# --- set options ---

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

# shell brace
set -B
#set -o braceexpand
echo lily{,-saber{,-brace}}

# show set options
echo "$-"

# --- variable ---
var="hi"
echo $var

readonly var="hello"

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

doller() {
  cat <<END
  return var $?
  recently background pid $!
  flags $-
  self pid $$
  argc $#
  argv $* : $@
  line $LINENO
END
  # cat <<END..END is one line
  # $LINENO is show it
}
sleep 1 & # for $1
doller hello lily


# array use ()
echo "--- array ---"
arr=(hi lily saber)
echo $arr
echo ${arr[1]}
echo ${#arr} # length of index?
#echo ${arr[3]} # error unbound variable
echo

set +u
# exchange
echo "--- = ---"
unset exchange
echo ${exchange=hello} # if unused then, modify and return it
echo $exchange
exchange="" # "" is NULL
echo ${exchange=world} # not modify

echo "--- := ---"
unset exchange
exchange=""
echo ${exchange:=world} # accept modify on NULL
echo $exchange
echo

echo "--- - ---"
unset exchange
echo ${exchange-lily} # if still non use then, return lily
echo empty$exchange # empty
exchange=lily-on
echo ${exchange-lily} # if used then, return contents
exchange=""
echo NULL${exchange-lily} # return NULL
echo

echo "--- :- ---"
unset exchange
echo ${exchange:-lily-hello} # same -
exchange=""
echo ${exchange:-lily-hello} # accept change on NULL
echo

echo "--- + ---"
unset exchange
exchange="hello"
echo ${exchange+lily-world} # if used then, return lily-nyan
unset exchange
echo NULL${exchange+lily-world} # if unused then, return NULL
exchange=""
echo ${exchange+lily-world} # with NULL, return lily-world
echo

echo "--- :+ ---"
unset exchange
exchange="hello"
echo ${exchange:+lily-nyan} # used: return lily-hello
exchange=""
echo ${exchange:+lily-nyan} # don't catch NULL, return NULL
set -u

# command in variable
function cmd_in_var () {
  local echo="echo"
  $echo "cmd_in_var"
  ${echo} "hello"
  "${echo}" "world"
}
cmd_in_var

# EOF
