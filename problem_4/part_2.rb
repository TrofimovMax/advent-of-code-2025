# frozen_string_literal: true
require 'benchmark'

time = Benchmark.realtime do
  file_path = File.join(__dir__, "hard.txt") # "easy.txt"
  orig = File.readlines(file_path, chomp: true).map(&:chars)

  rows = orig.size
  cols = orig.first.size

  grid = Array.new(rows + 2) { Array.new(cols + 2, '.') }
  rows.times do |r|
    cols.times do |c|
      grid[r + 1][c + 1] = orig[r][c]
    end
  end

  rows += 2
  cols += 2

  # 8 directions!
  neighbors = [
    [-1, -1], [-1, 0], [-1, 1],
    [0, -1],           [0, 1],
    [1, -1],  [1, 0],  [1, 1]
  ]

  total_removed = 0

  loop do
    reachable = Array.new(rows) { Array.new(cols, false) }
    queue = [[0, 0]]
    reachable[0][0] = true

    until queue.empty?
      r, c = queue.shift
      neighbors.each do |dr, dc|
        nr = r + dr
        nc = c + dc
        next if nr < 0 || nr >= rows || nc < 0 || nc >= cols
        next if reachable[nr][nc]
        next unless grid[nr][nc] == '.'
        reachable[nr][nc] = true
        queue << [nr, nc]
      end
    end

    to_remove = []
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

        if adjacent_rolls < 4
          to_remove << [r, c]
        end
      end
    end

    break if to_remove.empty?

    to_remove.each { |r, c| grid[r][c] = '.' }
    total_removed += to_remove.size
  end

  puts "Total deleted rolls: #{total_removed}"
end

puts "Execution time: #{time} seconds"
