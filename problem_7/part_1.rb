# frozen_string_literal: true
require 'benchmark'
require 'set'

time = Benchmark.realtime do
  file_path = File.join(__dir__, "hard.txt") # "easy.txt"
  lines = File.readlines(file_path, chomp: true)

  grid = lines.map(&:dup)
  rows = grid.size
  cols = grid.first ? grid.first.length : 0

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

  queue = []
  processed = Set.new
  activated_splitters = Set.new

  queue << [start_r, start_c]

  while !queue.empty?
    r0, c0 = queue.shift
    key = "#{r0},#{c0}"
    next if processed.include?(key)
    processed.add(key)

    r = r0
    c = c0

    loop do
      r += 1
      break if r >= rows
      cell = grid[r][c]

      if cell == '.' || cell == 'S'
        next
      elsif cell == '^'
        splitter_key = "#{r},#{c}"
        unless activated_splitters.include?(splitter_key)
          activated_splitters.add(splitter_key)
        end
        left_c = c - 1
        right_c = c + 1
        queue << [r, left_c] if left_c >= 0 && left_c < cols
        queue << [r, right_c] if right_c >= 0 && right_c < cols
        break
      else
        break
      end
    end
  end

  puts activated_splitters.size
end

puts "Execution time: #{time} seconds"
