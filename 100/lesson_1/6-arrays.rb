arr = [1,3,5,7,9,11]
number = 3
#arr.select {|value| value == number}
puts "Is included = " + arr.include?(number).to_s

newarr = ["b", "a"]
newarr = newarr.product(Array(1..3))
newarr.first.delete(newarr.first.last)
puts newarr.to_s

newarr2 = ["b", "a"]
newarr2 = newarr2.product([Array(1..3)])
newarr2.first.delete(newarr2.first.last)
puts newarr2.to_s

arr3 = [["test", "hello", "world"],["example", "mem"]]
puts arr3.last.first

string = "Welcome to America!"
a = string[6]
b = string[11]
c = string[19]
puts "#{a}#{b}#{c}"

start = [1,2,3]
finish = start.map{|value| value + 2}
p start
p finish