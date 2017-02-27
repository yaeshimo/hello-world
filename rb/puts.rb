#!/bin/ruby
if __FILE__ != $0; exit 1; end

puts "hi:"
a = "hello"
puts "hi: #{a}"
puts "hi: #{puts}#{a}"
# just like bash echo "$($()$())"

puts "--- def b ---"
def b; 1+2; end
puts "hi: #{puts b()}#{a}"
