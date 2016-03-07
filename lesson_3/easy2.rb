# Question 1
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
#puts ages.fetch("Spot")
#puts ages.any? { |k,v| k == "Spot"}
puts ages.has_key?("Spot")

#other answers
puts ages.include?("Spot")
puts ages.member?("Spot")

# Question 2
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
total = 0
ages.values.each do |age|
  total += age
end
p total

# posted solution
p ages.values.inject(:+)

# Question 3
ages2 = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
ages2.select! do |k,v|
  v < 100
end
p ages2

#posted solution
ages2.keep_if { |name, age| age < 100 }

# Question 4
munsters_description = "The Munsters are creepy in a good way."

p munsters_description.capitalize
p munsters_description.swapcase
p munsters_description.downcase
p munsters_description.upcase

# Question 5

ages3 = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
additional_ages = { "Marilyn" => 22, "Spot" => 237 }
ages3.merge!(additional_ages)
p ages3

# Question 6
ages4 = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
p ages4.values.min_by { |x| x }

#posted solution - ages.values.min

# Question 7
advice = "Few things in life are as important as house training your pet dinosaur."
p advice.include?("Dino")

# posted solution
p advice.match("Dino")

# Question 8
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
index = 0
flintstones.each_with_index do |v,i|
  if v.start_with?("Be")
    index = i
  end
end
p index

# solution given flintstones.index { |name| name[0,2 == "Be"]}

# Question 9
flintstones2 = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones2.map! { |name| name.slice(0..2)}

# solution given - flintstones2.map! { |name| name[0,3]}

#Question 10
flintstones2 = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones2.map! { |name| name[0,3]}