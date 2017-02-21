#!/usr/bin/awk -f

BEGIN {

  print "hello world"

  printf "%s\n" , "hello world"

  ORS = "\n\nORS is delimiter\n\n"
  print "changed delim"
}
