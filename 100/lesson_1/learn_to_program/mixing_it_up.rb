puts 'What is your first name'
first = gets.chomp
puts 'What is your middle name'
middle = gets.chomp
puts 'What is your last name'
last = gets.chomp
puts 'Well hello ' + first + ' ' + middle + ' ' + last
puts 'Whats your social security number' 
joke = gets.chomp
puts 'Just kidding... ' + joke + '? Seriously?'


puts 'On a serious note'
puts 'What is your favorite number'
number = gets.chomp.to_i
puts 'Have you considered upgrading your favorite number to... oh say...' + (number + 1).to_s + '?'

puts 'by the way, there are ' + (first.length + middle.length + last.lenght).to_s + ' letters in your name'