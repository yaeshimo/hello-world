#!/bin/ruby
if __FILE__ != $0; exit 1; end

puts :george.object_id == :george.object_id
puts "george".object_id == "george".object_id
