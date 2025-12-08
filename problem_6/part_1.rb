# frozen_string_literal: true
require 'benchmark'

time = Benchmark.realtime do
  file_path = File.join(__dir__, "hard.txt") # "easy.txt"
  lines = File.readlines(file_path, chomp: true)

  ops_line = lines.pop
  ops_chars = ops_line.strip.split(/\s+/)

  num_cols = ops_chars.size

  columns = Array.new(num_cols) { [] }

  lines.each do |line|
    nums = line.strip.split(/\s+/).map(&:to_i)
    nums.each_with_index do |n, idx|
      columns[idx] << n
    end
  end

  operations = {
    '*' => ->(a, b) { a * b },
    '+' => ->(a, b) { a + b }
  }

  grand_total = 0

  columns.each_with_index do |col_nums, idx|
    op_char = ops_chars[idx]
    op = operations[op_char]
    result = col_nums.reduce { |a, b| op.call(a, b) }
    grand_total += result
  end

  puts "Grand total: #{grand_total}"
end

puts "Execution time: #{time} seconds"
