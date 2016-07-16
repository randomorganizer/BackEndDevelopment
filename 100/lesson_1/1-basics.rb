#Exercise 1
puts "1. String Concatenation"
first_name = "Ron"
last_name =  "Jackson"
puts first_name + " " + last_name
puts "Fancy #{first_name} #{last_name}" # The fancy way shown in the solution video :)

#Exercise 2
puts "2. Modulo & Division"
big_number = 2025
puts (big_number - (big_number % 1000))/1000
puts (big_number % 1000) / 100
puts (big_number % 100) /10
puts (big_number % 10)
# your solution was much cleaner

puts "3. List of Movie Dates"
movies = {:back_to_the_future => 1985, :howard_the_duck => 1986, :short_circuit_2 => 1988}
#movies.each { |key,value| puts value } my initial solution
puts movies[:back_to_the_future]
puts movies[:howard_the_duck]
puts movies[:short_circuit_2]

puts "4. List of Movie Dates with Array"
yearArray = []
movies.each do |key,value|
  yearArray.push(value)
end
puts yearArray[0]
puts yearArray[1]
puts yearArray[2]

puts "5. Factorials"
#hmm had to look this up on internet
puts 5 * 4 * 3 * 2 * 1
puts 6 * 5 * 4 * 3 * 2 * 1
puts 7 * 6 * 5 * 4 * 3 * 2 * 1
puts 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1

puts "6. Squares"
puts 4.5 * 4.5
puts 5.1 * 5.1
puts 3.14 * 3.14
