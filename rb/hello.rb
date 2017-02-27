#!/bin/ruby

# FROM: www.ruby-lang.org
# quickstart

puts "--- hello ruby ---"
puts "hello world"
puts 2+3
puts 4*2
puts Math.sqrt(9)

a = 3 ** 2
puts a
b = 4 ** 2
puts b
puts Math.sqrt(a+b)

# function
def hi
  puts "from hi:hello world"
end
hi
hi()

# override
def hi(name)
  puts "Hello #{name}"
end
hi("lily")
hi "lily"
# error
#hi()

# default parameter
def hi(name = "World")
  puts "Hello #{name.capitalize}"
end
hi
hi "lily"


class Greeter
  def initialize(name = "World")
    @name = name
  end
  def say_hi
    puts "Hi #{@name}!"
  end
  def say_bye
    puts "Bye #{@name}, come back soon."
  end
end

greeter = Greeter.new("lily")
greeter.say_hi
puts "--- INSTANCE_METHODS BEGIN ---"
# show all
#puts Greeter.instance_methods
# show self definition
puts Greeter.instance_methods(false)
puts "--- INSTANCE_METHODS END ---"

puts "greeter respond_to?"
puts greeter.respond_to?("name")
puts greeter.respond_to?("say_hi")
puts greeter.respond_to?("to_s")

puts "Greeter attr_accessor :name"
class Greeter
  attr_accessor :name
  # created methods
  ## name
  ## name=
end
greeter = Greeter.new("arch")
puts greeter.respond_to?("name")
puts greeter.respond_to?("name=")
greeter.say_hi
puts greeter.name

# use accessor
greeter.name = "lily"
greeter.say_hi


puts "--- MegaGreeter ---"
class MegaGreeter
  attr_accessor :names

  # Create the object
  def initialize(names = "World")
    @names = names
  end

  # Say hi to everybody
  def say_hi
    if @names.nil?
      puts "..."
    elsif @naems.respond_to?("each")
      # @names is alist of some kind, iterate
      @names.each do |x|
        puts "Hello #{x}"
      end
    else
      puts "Hello #{names}"
    end
  end

  # Say bye to everybody
  def say_bye
    if @names.nil?
      puts "..."
    elsif @names.respond_to?("join")
      # Join the list elements with commas
      puts "Goodbye #{@names.join(", ")} Come back soon"
    else
      puts "Goodbye #{@names} Come back soon"
    end
  end
end


# like bash echo $0
puts __FILE__
puts $0
if __FILE__ == $0
  mg = MegaGreeter.new
  mg.say_hi
  mg.say_bye

  # Change name to be "Zeke"
  mg.names = "Zeke"
  mg.say_hi
  mg.say_bye

  # Change the name to an array of names
  mg.names = ["Albert", "Brenda", "Charles",
              "Dave", "Engelbert"]
  mg.say_hi
  mg.say_bye

  # Change to nil
  mg.names = nil
  mg.say_hi
  mg.say_bye
end
