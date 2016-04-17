def times(num)
  counter = 0
  while counter < num  do
    yield(counter)
    counter += 1  
  end

  num
end

test = times(5) do |num|
  puts num
end
puts test.inspect
