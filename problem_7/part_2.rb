# frozen_string_literal: true
require 'benchmark'

time = Benchmark.realtime do
  file_path = File.join(__dir__, "hard.txt") # "easy.txt"
  lines = File.readlines(file_path, chomp: true)

  grid = lines.map(&:dup)
  rows = grid.size
  cols = rows > 0 ? grid.first.length : 0

  start_r = start_c = nil
  grid.each_with_index do |row, r|
    c = row.index('S')
    if c
      start_r = r
      start_c = c
      break
    end
  end

  unless start_r
    puts "The S character was not found in the input file."
    exit 1
  end

  counts = Array.new(rows) { Array.new(cols, 0) }
  counts[start_r][start_c] = 1

  final_timelines = 0

  (start_r).upto(rows - 1) do |r|
    (0...cols).each do |c|
      cnt = counts[r][c]
      next if cnt == 0

      below_r = r + 1
      if below_r >= rows
        final_timelines += cnt
        next
      end

      below_cell = grid[below_r][c]
      if below_cell == '^'
        left_c = c - 1
        right_c = c + 1
        counts[below_r][left_c] += cnt if left_c.between?(0, cols - 1)
        counts[below_r][right_c] += cnt if right_c.between?(0, cols - 1)
      else
        counts[below_r][c] += cnt
      end
    end
  end

  puts "Timelines: #{final_timelines}"
end

puts "Execution time: #{time} seconds"
