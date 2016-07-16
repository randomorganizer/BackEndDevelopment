puts 'Boss: What do YOU want?'
answer = gets.chomp
puts 'WHADDAYA MEAN "' + answer.upcase + '"?!?  YOU\'RE FIRED!!'

lineWidth = 50
puts "Now for formatting"
puts 'Table of Contents'.center lineWidth
puts 'Chapter 1: Numbers'.ljust(lineWidth/2) + 'page 1'.rjust(lineWidth/2)
puts 'Chapter 2: Letters'.ljust(lineWidth/2) + 'page 72'.rjust(lineWidth/2)
puts 'Chapter 3: Variables'.ljust(lineWidth/2) + 'page 118'.rjust(lineWidth/2)


puts 'now for math'
puts (25**0.5).to_s

puts rand
puts rand
puts rand
puts rand(1)
puts rand(10)
puts rand(100)
puts rand(101)


puts 'now for the srand'
srand 1776
puts(rand(100))
puts(rand(100))
puts(rand(100))
puts(rand(100))
puts(rand(100))
puts ''
srand 1776
puts(rand(100))
puts(rand(100))
puts(rand(100))
puts(rand(100))
puts(rand(100))