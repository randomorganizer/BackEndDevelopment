require 'pry'
require 'yaml'
LANGUAGE = 'en'.freeze
MESSAGES = YAML.load_file('calculator_messages.yml')

def messages(message, lang = 'en')
  MESSAGES[lang][message]
end

def get_string(key)
  messages(key, LANGUAGE)
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def calculate(a, b, operation)
  case operation
  when "1" then return a.to_f() + b.to_f()
  when "2" then return a.to_f() - bto_f()
  when "3" then return a.to_f() * b.to_f()
  when "4" then return a.to_f() / b.to_f()
  else prompt(get_string('operation?'))
  end
end

def valid_number?(number)
  return true if valid_integer?(number)
  return true if valid_float?(number)
  false
end

def valid_integer?(number)
  # found on SO http://stackoverflow.com/questions/1235863/test-if-a-string-is-basically-an-integer-in-quotes-using-ruby
  number.to_i().to_s() == number
end

def valid_float?(number)
  if number.include? "."
    number = number.to_f.to_s
    value1 = number.split(".").first
    value2 = number.split(".").last
    return true if valid_integer?(value1) && valid_integer?(value2)
    return false
  end
end

def operation_to_message(operation)
  case operation
  when '1'
    return prompt(get_string('adding'))
  when '2'
    return prompt(get_string('subtracting'))
  when '3'
    return prompt(get_string('multiplying'))
  when '4'
    return prompt(get_string('dividing'))
  end
end

prompt(get_string('welcome'))

name = ''
loop do
  name = Kernel.gets().chomp()
  break unless name.empty?() # rubocop told me to use this guard clause
  prompt(get_string('valid_name'))
end
prompt("#{get_string('hi')} #{name}!")

loop do # main loop
  first_number = ''
  loop do
    prompt(get_string('first_number'))
    first_number = Kernel.gets().chomp()
    break if valid_number?(first_number)
    prompt(get_string('invalid_number'))
  end
  second_number = ''
  loop do
    prompt(get_string('second_number'))
    second_number = Kernel.gets().chomp()
    break if valid_number?(second_number)
    prompt(get_string('invalid_number'))
  end
  operation = ''

  prompt(get_string('operator_prompt'))
  loop do
    operation = Kernel.gets().chomp()
    break if %w(1 2 3 4).include?(operation)
    prompt(get_string('choose_number'))
  end

  prompt("#{operation_to_message operation} #{get_string('operation_status')}")

  result = calculate(first_number, second_number, operation)
  prompt("#{get_string('result')} #{result}")
  prompt(get_string('continue'))
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end
prompt(get_string('good-bye'))
