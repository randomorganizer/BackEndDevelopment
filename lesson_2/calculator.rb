def calculate(a, b, operation)
  case operation
  when "1" then return a.to_i() + b.to_i()
  when "2" then return a.to_i() - bto_i()
  when "3" then return a.to_i() * b.to_i()
  when "4" then return a.to_f() / b.to_f()
  else puts "Operation not recognized"
  end
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(number)
  number.to_i() != 0
end

def operation_to_message(operation)
  case operation
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

prompt("Welcome to Calculator! Enter your name:")

name = ''
loop do
  name = Kernel.gets().chomp()
  break unless name.empty?() # rubocop told me to use this guard clause
  prompt("Make sure to use a valid name.")
end
prompt("Hi #{name}!")

loop do # main loop
  first_number = ''
  loop do
    prompt("Enter first number")
    first_number = Kernel.gets().chomp()
    break if valid_number?(first_number)
    prompt("Not a valid number")
  end

  second_number = ''
  loop do
    prompt("Enter second number")
    second_number = Kernel.gets().chomp()
    break if valid_number?(second_number)
    prompt("Not a valid number")
  end
  operation = ''
  operator_prompt = <<-MSG
    Enter an operation:
    1) Add
    2) Subtract
    3) Multiply
    4) Divide
  MSG
  prompt(operator_prompt)
  loop do
    operation = Kernel.gets().chomp()
    break if %w(1 2 3 4).include?(operation)
    prompt("Must choose 1, 2, 3, or 4")
  end

  prompt("#{operation_to_message operation} the two numbers...")

  result = calculate(first_number, second_number, operation)
  prompt("The result is #{result}")
  prompt("Do you want to preform another calculation? Y/N")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end
prompt("Thank you for using the Calculator! Good-Bye")
