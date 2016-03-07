# Question 1
puts phrase = "The Flintstones Rock!"
10.times do
  phrase.prepend(" ")
  puts phrase + "\n"
end

# given solution 10.times { |number| puts (" " * number) + "The Flintstones Rock!"}

#Question 2
statement = "The Flintstones Rock"
letters = statement.chars
#count = Hash.new(0)
count = {}
letters.each do |letter|
  next if letter == " "
  if(count.include?(letter))
    count[letter] += 1
  else
    count[letter] = 1
  end
end
puts count

#given solution
# result = {}
# letters = ('A'..'Z').to_a + ('a'..'z').to_a
# letters.each do |letter|
#   letter_frequency = statement.scan(letter).count
#   result[letter] = letter_frequency if letter_frequency > 0
# end
# puts result

# Question 3
puts "the value of 40 + 2 is " + (40 + 2).to_s
puts "the value of 40 + 2 is #{40 + 2}"

# Question 4
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end
p numbers
# will remove first 2 numbers, cycling only twice
# the index on the cycle stays the same despite shifting

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end
p numbers
# will print 1 and 2 and array will contain 1 and 2

# Question 5
def factors(number)
  dividend = number
  divisors = []
  until dividend <= 0 
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end
  divisors
end
p factors(25)

# number % divident == 0 determines if number divides evenly
# divisors returns the divisors array to the caller

# Question 6
# Yes the difference is that + will create a new object and << will mutate the original object

# Question 7
limit = 15

def fib(first_num, second_num, limit)
  while second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, limit)
puts "result is #{result}"

# Question 8
marquee = "Harry and the Hendersons"
def titleize(input)
  words = input.split(' ')
  words.map! { |word| word.capitalize }
  words.join(' ')
end
puts titleize(marquee)

# given solution words.split.map { |word|.capitalize }.join(' ')

# Question 9
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |k,v|
  case v["age"]
  when 0..17
    v["age_group"] = "kid"
  when 18..64
    v["age_group"] = "adult"
  else
    v["age_group"] = "senior"
  end
end
p munsters