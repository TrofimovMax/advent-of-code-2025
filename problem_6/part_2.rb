# frozen_string_literal: true
require 'benchmark'

time = Benchmark.realtime do
  file_path = File.join(__dir__, "easy.txt") # "hard.txt"
  lines = File.readlines(file_path, chomp: true)

  ops_line = lines.pop
  ops_chars = ops_line.strip.split(/\s+/)
  puts lines.inspect
end

puts "Execution time: #{time} seconds"
