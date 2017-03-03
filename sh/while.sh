#/bin/sh
set -e

counter=0
while true; do
  echo "hi: $counter"
  test $counter -gt 10 && break
  counter=$(expr $counter + 1)
done

counter=0
while test $counter -lt 10; do
  echo "  hi: $counter"
  counter=$(expr $counter + 1)
done
# EOF
