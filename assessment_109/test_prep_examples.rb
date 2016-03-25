# local var scope

str1 = 'hello'

def my_method
  puts str1
end

#my_method

# local variables do not blead through in their scope
# they have to be passed in


str2 = 'world'

[1].each do |n|
  puts str2
end

# local variable scoping rules are different for blocks vs methods
# blocks form an inner scope and have access to their outer scope

str3 = 'world'
[1].each do |n|
  puts str2
  str2 = 'a new string'
end

puts str2

# what will str2 output?
# variable initialization and variable assignment can look the same


[1].each do |n|
  str4 = 'a new string'
end

# puts str4

# how can you make this code run without initializing a local variable
# you could define a method with the scope with the same name
# because methods don't require () it is vague if variables are local variables or methods


# method arguments

def run(str)
  str << ' world'
end

a = 'hello'
run a

puts a

# what happens to a?
# << mutates a
# some say Ruby is pass by reference because of this.
# in a 100% pure pass by value language the value would be hello
# in a pass by value language you would have to return the value to use it, which is a cleaner approach

# it is not pass by value because we can change arguments that we pass in to the method invocation
# but it is not 100% pass by reference either
# see below

def run2(str)
  str = 'hello world'
  # same things as str += ' world'
end

a2 = 'hello'
run2 a2
puts a2

# reassignment does not affect the a2 variable



# collections - know hash and array methods

# blocks - know when you would want to write a block
# closures are a key to how local variable scope works in ruby
# closures builds and enclosre around its surrounding context
# in ruby closures are called a binding, it drags along surrounding artifacts
# this is why we say a block has access to outer scope variables because it builds this enclosure

# why would we want to write a method that takes blocks?


