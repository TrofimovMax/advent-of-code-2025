# frozen_string_literal: true
require 'benchmark'

filename = "hard.txt" # "easy.txt"
time = Benchmark.realtime do
  points = File.readlines(File.join(__dir__, filename), chomp: true)
               .reject(&:empty?)
               .map.with_index { |l,i| [i, *l.split(',').map(&:to_i)] }

  n = points.size

  pairs = []
  (0...n).each do |i|
    xi, yi, zi = points[i][1..3]
    ((i+1)...n).each do |j|
      xj, yj, zj = points[j][1..3]
      dx, dy, dz = xi-xj, yi-yj, zi-zj
      pairs << [dx*dx + dy*dy + dz*dz, i, j]
    end
  end

  pairs.sort_by!(&:first)

  parent = Array.new(n) { |i| i }
  size = Array.new(n,1)

  find = ->(x) { parent[x] == x ? x : parent[x] = find.call(parent[x]) }
  union = ->(a,b) {
    ra, rb = find.call(a), find.call(b)
    return false if ra == rb
    ra, rb = rb, ra if size[ra] < size[rb]
    parent[rb] = ra
    size[ra] += size[rb]
    size[rb] = 0
    true
  }

  last_pair = nil
  pairs.each do |_, i, j|
    if union.call(i,j)
      last_pair = [points[i][1], points[j][1]]
      break if size[find.call(i)] == n
    end
  end

  if last_pair
    x_product = last_pair[0] * last_pair[1]
    puts "Last pair X coordinates: #{last_pair}"
    puts "Product of last X coordinates: #{x_product}"
  else
    puts "Already all in one circuit"
  end
end

puts "Execution time: #{time} seconds"
