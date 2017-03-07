#!/bin/sh
set -eu

echo "----- brace -----"
echo {h,l,l,o}
echo {0..10}
echo {0..256..32}
echo {a..z}
echo {A..z}
echo path/{to,next}/file
echo path/{,to,next}/file
echo path/{to,next,}/file
echo path/{to,nest{,next}}/file

# EOF
