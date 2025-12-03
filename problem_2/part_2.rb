# frozen_range_literal: true

# @param {range} s
# @return {Boolean}
def repeated_sequence?(s)
  max_block_length = s.length / 2

  (1..max_block_length).each do |block_length|
    block = s[0, block_length]
    repeats = s.length / block_length

    if repeats >= 2
      repeated_string = block * repeats
      return true if repeated_string == s
    end
  end

  false
end

file_path = File.join(__dir__, "hard.txt") # "easy.txt"
ranges  = File.read(file_path, chomp: true).gsub("\n", "").split(",")

sum = 0

ranges.each do |range|
  from_str, to_str = range.split("-")
  from = from_str.to_i
  to   = to_str.to_i

  puts "Running for #{from} to #{to}"
  (from..to).each do |id|
    if repeated_sequence?(id.to_s)
      puts "invalid ID: #{id}"
      sum += id
    end
  end
end

puts "SUM = #{sum}"
