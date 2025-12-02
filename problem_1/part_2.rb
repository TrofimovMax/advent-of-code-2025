# frozen_string_literal: true

file_path = File.join(__dir__, "hard.txt") # "easy.txt"
lines = File.readlines(file_path, chomp: true)

position = 50
count = 0

lines.each do |line|
  direction, amount = line.split(/(?<=^[LR])/)
  amount = amount.to_i

  if direction == 'R'
    amount.times do
      position = (position + 1) % 100
      count += 1 if position == 0
    end
  else
    amount.times do
      position = (position - 1) % 100
      count += 1 if position == 0
    end
  end
end

puts count.inspect
