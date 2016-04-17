def reduce(array, initial=0)
  counter = 0
  result = initial
  while counter < array.size
    result = yield(result, array[counter])
    counter += 1
  end
  result
end

array = [1, 2, 3, 4, 5]

p reduce(array) { |acc, num| acc + num }
p reduce(array, 10) { |acc, num| acc + num }
p reduce(array) { |acc, num| acc + num if num.odd? }

