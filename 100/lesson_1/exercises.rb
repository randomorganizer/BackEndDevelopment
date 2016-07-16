puts "Exercise 1"
list = [1,2,3,4,5,6,7,8,9,10]
list.each {|number| p number}

puts "Exercise 2"
list.each do |number|
  if number>5
    puts number
  end
end

puts "Exercise 3"
oddnumbers = list.select { |number| (number%2) == 1}
# I like the number.odd? option given in the solution
puts oddnumbers

puts "Exercise 4"
list.push(11)
list.unshift(0)
puts list

puts "Exercise 5"
list.pop()
list << 3
puts list

puts "Exercise 6"
list.uniq!
puts list

puts "Exercise 8"
house1 = {:has_garage => true, :elevation => "craftsman", :price => 150000 }
house2 = {has_garage: false, elevation: "colonial", price: 130000}
puts house1.to_s
puts house2.to_s

puts "Exercise 9"
h = {a:1, b:2, c:3, d:4}
puts h[:b]
puts h[:e] = 5
puts h.delete_if {|key, value| value < 3.5 } 

puts "Exercise 10"
place = {states: ['texas, california, michigan']}
puts place

person1 = {name: "bob"}
person2 = {name: "frank"}
person3 = {name: "sarah"}

people = [person1, person2, person3]
puts people

puts "Exercise 12"
contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

index = 0
keys = contacts.keys #http://stackoverflow.com/questions/15131234/how-to-get-a-hash-value-by-numeric-index
contact_data.each do |contact|
  contacts[keys[index]] = {email: contact[0],
    address: contact[1],
    phone: contact[2]}
  index += 1
end

puts contacts

puts "Exercise 13"
puts contacts["Joe Smith"][:email]
puts contacts["Sally Johnson"][:phone]

puts "Exercise 14"
puts contacts
#I should have used the each_with_index that the instructor demonstrated


puts "Exercise 15"
words = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']
puts words.delete_if{|word| word.start_with?('s')}
puts words.delete_if{|word| word.start_with?('s') || word.start_with?('w')}

puts "Exercise 16"
a = ['white snow', 'winter wonderland', 'melting ice',
     'slippery sidewalk', 'salted roads', 'white trees']
puts "Array length before: #{a.length}"
a.map!{|item| item.split(' ')}
a.flatten!
puts "Array length after: #{a.length}"