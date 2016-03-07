# Question 1
# Uniq will remove any duplicates and return a new array

numbers = [1, 2, 2, 3]
numbers.uniq

#numbers will be exactly the same because uniq is non-destructive
puts numbers


# Question 2
# What is the difference between ! and ? in Ruby
# The ! operator will negate the truthiness of something
# The ? is part of the ternary operation

# 1 != is not equals and it is used between to values or variables
1 != 2
# 2 !2 == 3
user_name = nil
if !user_name
  puts "You need to log in"
end
# 3 mutates an array by removing any repeats
["mi", "casa", "es", "su", "casa"].uniq! # last casa removed
# 4 ternary operator
puts (!!"Han shot first" == true) ? "All is well" : "Where am I?"
# 5 used to denote a method that returns true or false (convention)
empty_variable = ''
empty_variable.empty?
# !! converts a variable or value to a boolean
def happy?
  if "rubying"
    !!"happy"
  else
    !"happy"
  end
end


# Question 3
advice = "Few things in life are as important as house training your pet dinosaur"
puts advice.sub! "important", "urgent"

# Question 4
numbers = [1, 2, 3, 4, 5]
numbers.delete_at(1) # will delete #2 at the 1 index
numbers.delete(1) # will delete all the 1s in the array

# Question 5
p (10..100).include?(42)

# Question 6
famous_words = "seven years ago..."
famous_start = "Four score and "
famous_start << famous_words
famous_start2 = "Four score and "
famous_start2 += famous_words
puts famous_start
puts famous_start2

# Question 7
def add_eight(number)
  number + 8
end

number = 2

how_deep = "number"
5.times { how_deep.gsub!("number", "add_eight(number)") }

p how_deep
p eval(how_deep)
# Whoa

# Question 8
flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]
p flintstones.flatten!

# Question 9
flintstones2 = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
character_search = flintstones2.select { |k,v| k == "Barney"}
character = character_search.shift
p character

# Question 10
flintstones3 = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
flintstones_hash = {}
flintstones3.each_with_index do |v,i|
  flintstones_hash[v] = i
end
p flintstones_hash