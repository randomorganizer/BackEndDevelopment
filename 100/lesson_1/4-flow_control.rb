def capitalize_the_long(text)
  if(text.length > 10)
    text = text.upcase
  end
  return text
end

puts capitalize_the_long('hello World')



def evaluate_number(number)
  if(number >= 0 && number <= 50)
    puts "That number is between 0 and 50"  
  elsif (number >= 51 && number <= 100)
    puts "That number is between 51 and 100"
  elsif (number > 100)
    puts "That number is greater than 100"
  else
    puts "You need to pick a positive number"
  end
end
puts "Pick a number"
number = gets.chomp.to_i
evaluate_number(number)


def evaluate_number_case(number)
  case
  when number >= 0 && number <= 50
    puts "That number is between 0 and 50"  
  when number >= 51 && number <= 100
    puts "That number is between 51 and 100"
  when number > 100
    puts "That number is greater than 100"
  else
    puts "You need to pick a positive number"
  end
end

puts "Pick another number"
number2 = gets.chomp.to_i
evaluate_number_case(number2)