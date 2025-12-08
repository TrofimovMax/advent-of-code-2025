# frozen_range_literal: true
require 'benchmark'

time = Benchmark.realtime do
  file_path = File.join(__dir__, "hard.txt") # "easy.txt"
  lines = File.readlines(file_path, chomp: true)

  blank_index = lines.index("")
  range_lines = lines[0...blank_index]
  id_lines    = lines[(blank_index + 1)..]

  ranges = range_lines.map do |line|
    a, b = line.split("-").map(&:to_i)
    (a..b)
  end

  ids = id_lines.map(&:to_i)

  fresh_count = ids.count do |id|
    ranges.any? { |r| r.cover?(id) }
  end

  puts "Fresh ingredients: #{fresh_count}"
end

puts "Execution time: #{time} seconds"
