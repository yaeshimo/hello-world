#!/bin/ruby
if __FILE__ != $0; exit 1; end

#class MyClass
#  attr_accessor :instance_var
#end

# same
Myclass = Class.new do
  attr_accessor :instance_var
end


puts "--- Accesss ---"
class Access
  private
  def a_method; true; end
  def a_another_method; false; end
  public
  def b_method; 10; end
  def b_another_method; 20; end
  def c_method; a_method; end
end
# a_another_method is private
puts Access.new.b_another_method
puts Access.new.c_method

puts "--- Car ---"
class Car
  def inspect
    "Cheap car"
  end
end
puts "porsche:>>"
porsche = Car.new
puts porsche.inspect
def porsche.inspect
  "Expensive car"
end

puts "other_car:>>"
other_car = Car.new
puts other_car.inspect

puts "porsche:>>"
puts porsche.inspect

