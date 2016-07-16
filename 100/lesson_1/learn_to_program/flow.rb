bottles = 99

while bottles >= 1
  puts bottles.to_s + ' bottles of beer on the wall, blah blah one fell'
  bottles -= 1
end

puts rand(3)
puts rand(3)
puts rand(3)

puts 'Grandma just entered the room, you should greet her.'
bye_counter = 0
while bye_counter < 3
  greeting = gets.chomp
  while greeting != 'BYE'
    bye_counter = 0
    if greeting == greeting.upcase
      puts 'NO, NOT SINCE ' + (1930 + rand(21)).to_s
    else
      puts 'HUH?! SPEAK UP, SONNY!'
    end
    greeting = gets.chomp
  end
  bye_counter += 1
end
puts 'He leaves the room'



def calculate_leaps(start, finish)
  while start <= finish
    if start % 4 == 0 && (start % 100 != 0 || start % 400 == 0)
      puts start
    end
    start += 1
  end
end

calculate_leaps(1981, 2016)