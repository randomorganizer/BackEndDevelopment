# Question 1
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones

#Question 2
flintstones2 = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones2 << "Dino"
p flintstones2

# Question 3
flintstones3 = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones3 << "Dino" << "Hoppy"
p flintstones3

# solution given flintstones3.concat(%w(Dino Hoppy))

# Question 4
advice = "Few things in life are as important as house training your pet dinosaur."
p advice.slice!("Few things in life are as important as ")
p advice

advice2 = "Few things in life are as important as house training your pet dinosaur."
p advice2.slice("Few things in life are as important as ")
p advice2

# given solution - advice.slice!(0, advice.index('house'))

# Question 5
statement = "The Flintstones Rock!"
p statement.count("t")

# given solution statement.scan("t").count

# Question 6
title = "Flintstone Family Members"
p title.center(40)