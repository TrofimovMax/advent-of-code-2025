# frozen_range_literal: true

# @param {range} s
# @return {Boolean}
def double_repeat?(s)
  if s.length.odd?
    false
  else
    half = s.length / 2
    s[0, half] == s[half, half]
  end
end

file_path = File.join(__dir__, "easy.txt") # "hard.txt"
ranges  = File.read(file_path, chomp: true).gsub("\n", "").split(",")

sum = 0

ranges.each do |range|
  from_str, to_str = range.split("-")
  from = from_str.to_i
  to   = to_str.to_i

  puts "Running for #{from} to #{to}"
  (from..to).each do |id|
    if double_repeat?(id.to_s)
      puts "invalid ID: #{id}"
      sum += id
    end
  end
end

puts "SUM = #{sum}"
