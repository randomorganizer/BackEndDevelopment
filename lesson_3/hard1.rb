# Question 1
if false
  greeting = “hello world”
end

greeting

# Question 2
greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings

# both say hi there

# Question 3
def mess_with_vars(one, two, three)
  one = two
  two = three
  three = one
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"

def mess_with_vars2(one, two, three)
  one = "two"
  two = "three"
  three = "one"
end

one = "one"
two = "two"
three = "three"

mess_with_vars2(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"

def mess_with_vars3(one, two, three)
  one.gsub!("one","two")
  two.gsub!("two","three")
  three.gsub!("three","one")
end

one = "one"
two = "two"
three = "three"

mess_with_vars3(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"

# Question 4
def get_uuid
  characters = []
  letters = ('a'..'z').to_a
  numbers = (0..9).to_a
  characters.concat(letters)
  characters.concat(numbers)
  uuid = characters.sample(36)
  uuid = uuid.join('')
  uuid = uuid.insert(8,'-').insert(13,'-').insert(18,'-').insert(23, '-')
  uuid
end
# not pretty :(
p person_id = get_uuid


# Question 5
def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false if dot_separated_words.length != 4
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    return false if !is_a_number?(word)
  end
  return true
end
def is_a_number?(input)
  true
end

puts dot_separated_ip_address?("10.3.17.252")
puts dot_separated_ip_address?("10.3.17")