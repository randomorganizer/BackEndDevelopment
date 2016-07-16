def grandfather_clock(&chime)
  hours = Time.now.hour
  hours -= 12 if hours > 12
  hours.times do |n|
    chime.call
  end
end

grandfather_clock do
  puts 'DONG!'
end

puts
puts
puts

$nestingDepth = 0

def log(description, &code_block)
  puts '   '*$nestingDepth  + 'Beginning ' + description
  $nestingDepth += 1
  value = code_block.call
  $nestingDepth -= 1
  puts '   '*$nestingDepth + '... ' + description + ' finished, returning: ' + value.to_s

end

log 'outer block' do 
  log 'some little block' do
    5
  end
  log 'yet another block ...' do
    'I like Thai food!'
  end
  false
end