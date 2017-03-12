#!/bin/sh
set -e
echo "\$?==$? is true"

echo -e "\n----- test number -----"
test 1 -eq 1 && echo "true eq"
test 1 -ne 0 && echo "true ne"
test 0 -lt 1 && echo "true lt"
test 1 -gt 0 && echo "true gt"
  # l(less then)t <
  # g(greater then)t >
test 0 -le 0 && echo "true le"
test 0 -ge 0 && echo "true ge"

echo -e "\n----- string -----"
test "hello" = "hello" && echo "true hello"
test "hello" != "world" && echo "true world"
test -z "" && echo "string length 0"
test -n "a" && echo "string length > 0"

echo -e "\n----- time stamp -----"
test "$0" -nt "$(dirname $0)/hello.sh" &&
  echo "stamp newbie:$(basename "$0")"
test "$(dirname $0)/hello.sh" -ot "$0" &&
  echo "stamp newbie:hello.sh"

echo -e "\n----- file and directory -----"
test -d "$(pwd)" && echo "directory:$(pwd)"
test -f "$0" && echo "file:$(basename $0)"
test -s "$0" && echo "not empty:$(basename $0)"
test -e "$0" && echo "exist:$(basename $0)"
test -r "$0" && echo "readble:$(basename $0)"
test -w "$0" && echo "writable:$(basename $0)"
test -x "/bin/sh" && echo "executable:/bin/sh"

echo -e "\n----- and not or -----"
test -z "" -a -z "" && echo "and"
test ! -n "" && echo "not"
test -z "a" -o -z "" && echo "or"

echo -e "\n----- syntax sugar [ [[ -----"
which "["
[ -z "" ] && echo "simple"
# builtin on bash
# EXAMPLE: which "[["


echo -e "\n----- if -----"
if true; then
  echo "true"
fi

if false; then
  : # that same true
else
  echo "false"
fi

if false; then
  : # that same true
elif ! false; then
  echo "elif true"
else
  echo "can't show"
fi
# EOF
