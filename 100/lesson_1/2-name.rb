puts "Enter your first name"
#name = gets #I forgot the chomp
firstname = gets.chomp
puts "Enter your last name"
lastname = gets.chomp
name = firstname + ' ' + lastname
puts "Welcome to the future, #{name}"

10.times {|i| puts name}


