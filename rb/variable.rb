#!/bin/ruby
if __FILE__ != $0; exit 1; end

puts "--- value ---"
x = 10
y = 11
z = if x < y
      true
    else
      false
    end
puts z
# accept >> z = {statement}
# allways have a value

puts "--- const ---"
# Uppercase is const
Constant = 10
def Constant
  11
end
puts Constant
puts Constant()
# that confused
# recommend method definition is to lowercase

# can do change const value
# but do not recommend
# ruby is always warning to that
#Constant = 25
#puts Constant

puts "--- ___macro?___ ---"
# __FILE__ $0
puts __FILE__
# __LINE__ number of line from sorce
puts __LINE__

puts "--- class Variables ---"
# $.* is global
# @.* is variable of instance
# @@.* class variables
class Variables
  attr_accessor :hello
  @hello = "hello"
  @@world = ":class world"
  @@counter = 0

  def initialize(x = "hello", y = "")
    @@counter = @@counter+1
    @@world += y + " counter >>" + @@counter.to_s
    @hello = x
  end

  def say
    puts @hello
    puts @@world
  end
end

puts "--- var1 ---"
var1 = Variables.new
var1.say
var1.hello = "var1:hello"
var1.say

puts "--- var2 ---"
var2 = Variables.new("var2:hello", " :class world2")
var2.say
var1.say # var2.@@world == var1.@@world

# ruby >= 2.0
puts "--- keyword parameter ---"
def who(name: "lily", from: "arch", age: 14)
  puts "name=#{name}, from=#{from}, age#{age}"
end
who
who(name: "dory")
who(from: "mate", age: 11, name: "dory")

puts "--- true false ---"
# ! [ nil | false ] == true
if 0
  puts "0 is true"
else
  puts "0 is false"
end
