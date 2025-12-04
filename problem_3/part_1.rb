# frozen_range_literal: true

file_path = File.join(__dir__, "hard.txt") # "easy.txt"
blocks  = File.readlines(file_path, chomp: true).map do |line|
  line.chars.map(&:to_i)
end


sum_voltage = 0

blocks.each do |block|
  max_voltage_first = block[0]
  max_voltage_second = block[1]
  first_index = 0
  i = 1
  while i < block.length
    if block[i] > max_voltage_first && i < block.length - 1
      max_voltage_first = block[i]
      first_index = i
      max_voltage_second = block[i + 1..-1].max
    elsif i > first_index && block[i] > max_voltage_second
      max_voltage_second = block[i]
    end
    i += 1
  end
  puts "sum_voltage = #{max_voltage_first * 10} + #{max_voltage_second}"
  sum_voltage += max_voltage_first * 10 + max_voltage_second
end

puts sum_voltage.inspect
