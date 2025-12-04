# frozen_range_literal: true
require 'benchmark'

time = Benchmark.realtime do
  file_path = File.join(__dir__, "hard.txt") # "easy.txt"
  blocks  = File.readlines(file_path, chomp: true).map do |line|
    line.chars.map(&:to_i)
  end

  sum_voltage = 0
  target_length = 12

  blocks.each_with_index do |block, idx|
    stack = []
    to_remove = block.length - target_length

    block.each do |digit|
      while to_remove > 0 && !stack.empty? && stack[-1] < digit
        stack.pop
        to_remove -= 1
      end
      stack.push(digit)
    end

    max_digits = stack[0...target_length]
    max_number = max_digits.join.to_i
    # puts "Block #{idx}: max 12-digit number = #{max_number}"
    sum_voltage += max_number
  end
  puts sum_voltage.inspect
end

puts "Время выполнения: #{time} секунд"
