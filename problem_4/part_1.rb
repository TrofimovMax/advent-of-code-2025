# frozen_range_literal: true
require 'benchmark'

time = Benchmark.realtime do
  file_path = File.join(__dir__, "hard.txt") # "easy.txt"
  grid = File.readlines(file_path, chomp: true)

  rows = grid.size
  cols = grid.first.size

  neighbors = [
    [-1, -1], [-1, 0], [-1, 1],
    [0, -1],          [0, 1],
    [1, -1],  [1, 0], [1, 1]
  ]

  accessible_count = 0

  (0...rows).each do |r|
    (0...cols).each do |c|
      next unless grid[r][c] == '@'

      adjacent_rolls = 0

      neighbors.each do |dr, dc|
        nr = r + dr
        nc = c + dc
        next if nr < 0 || nr >= rows || nc < 0 || nc >= cols

        adjacent_rolls += 1 if grid[nr][nc] == '@'
      end

      accessible_count += 1 if adjacent_rolls < 4
    end
  end

  puts "Available rolls: #{accessible_count}"
end

puts "Execution time: #{time} seconds"
