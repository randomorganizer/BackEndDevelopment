def select(array)
  counter = 0
  selected_items = []
  while array.size > counter
    if (yield(array[counter]))
      selected_items.push(array[counter])
    end
    counter += 1
  end
  selected_items
end

array = [1, 2, 3, 4, 5]

p select(array) { |num| num.odd? }
p select(array) { |num| puts num }
p select(array) { |num| num + 1 }