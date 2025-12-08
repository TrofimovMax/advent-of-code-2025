# frozen_range_literal: true
require 'benchmark'

time = Benchmark.realtime do
  file_path = File.join(__dir__, "hard.txt") # "easy.txt"
  lines = File.readlines(file_path, chomp: true)

  blank_index = lines.index("")
  range_lines = lines[0...blank_index]

  ranges = range_lines.map do |line|
    a, b = line.split("-").map(&:to_i)
    [a, b]
  end

  ranges.sort_by! { |a, b| a }

  merged = []
  ranges.each do |a, b|
    if merged.empty? || merged.last[1] < a - 1
      merged << [a, b]
    else
      merged.last[1] = [merged.last[1], b].max
    end
  end

  total_fresh = merged.sum { |a, b| b - a + 1 }

  puts "Total fresh ingredients: #{total_fresh}"
end

puts "Execution time: #{time} seconds"
