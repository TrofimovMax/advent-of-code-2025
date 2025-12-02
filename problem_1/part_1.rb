# frozen_string_literal: true

file_path = File.join(__dir__, "hard.txt") # "easy.txt"
lines = File.readlines(file_path, chomp: true)

position = 50
count = 0

lines.each do |line|
  direction, amount = line.split(/(?<=^[LR])/)
  amount = amount.to_i

  puts "position before #{direction}: #{amount}"
  direction == 'R' ? position += amount : position -= amount
  position %= 100
  puts position.inspect
  count += 1 if position == 0
end

puts count.inspect
