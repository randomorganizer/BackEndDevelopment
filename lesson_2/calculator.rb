def calculate(a, b, operation)
  case operation
  when "add" then return a + b
  when "subtract" then return a - b
  when "multiply" then return a * b
  when "divide" then return a.to_f() / b.to_f()
  else puts "Operation not recognized"
  end
end

Kernel.puts("Enter 2 numbers seperated by a space")
numbers = Kernel.gets().chomp()
Kernel.puts("Enter an operation: add, subtract, multiply, or divide")
operation = Kernel.gets().chomp()

numbers_array = numbers.split(' ')
value_a = numbers_array[0].to_i()
value_b = numbers_array[1].to_i()
result = calculate(value_a, value_b, operation)
Kernel.puts("When you #{operation} #{value_a} and #{value_b} the result is #{result}")
