saywhen = "Keep Going"
while saywhen != "STOP"
  puts "Just say when, but not literally"
  saywhen = gets.chomp
end
puts "ok, ok, we'll #{saywhen}"



pogtypes = ['paper', 'plastic', 'metal']
pogtypes.each_with_index{ |type, number| puts "#{number}. #{type}"}


def countdown(number)
  puts number
  if number > 0
    number -= 1
    countdown(number)
  else
    puts "Blast off"
  end
end

countdown(10)