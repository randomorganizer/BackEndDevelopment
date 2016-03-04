require 'yaml'
STRINGS = YAML.load_file('mortgage_calculator.yml')
LANGUAGE = 'en'.freeze

def get_string(key, lang = 'en')
  STRINGS[lang][key]
end

def prompt(text)
  puts "=> #{text}"
end

def valid_integer?(input)
  input.to_i.to_s == input
end

def valid_float?(input)
  input.to_f.to_s == input
end

def valid_apr?(input)
  return true if valid_integer?(input)
  valid_float?(input)
end

prompt(get_string('greeting'))
loop do
  principal = nil
  loop do
    prompt(get_string('principal'))
    principal = gets.chomp
    if valid_integer?(principal)
      principal = principal.to_i
      break
    else
      prompt(get_string('invalid_number'))
    end
  end

  apr = nil
  loop do
    prompt(get_string('apr'))
    apr = gets.chomp
    if valid_apr?(apr)
      apr = apr.to_f / 100
      break
    else
      prompt(get_string('invalid_number'))
    end
  end

  duration = nil
  loop do
    prompt(get_string('duration'))
    duration = gets.chomp
    if valid_integer?(duration)
      duration = duration.to_f
      break
    else
      prompt(get_string('invalid_number'))
    end
  end

  monthly_rate = apr / 12.0
  total_payments = duration * 12
  monthly_payment = ((principal * monthly_rate) / (1 - (1 / ((1 + monthly_rate)**total_payments)))).round(2)
  total_paid = (monthly_payment * total_payments).round(2)
  interest_paid = (total_paid - principal).round(2)

  prompt("#{get_string('monthly_payment')} #{monthly_payment}")
  prompt("#{get_string('total_paid')} #{total_paid}")
  prompt("#{get_string('interest_paid')} #{interest_paid}")
  prompt(get_string('continue'))
  continue = gets.chomp
  break unless continue.downcase.start_with?('y')
end
