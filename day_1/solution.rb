File.open("source.txt", "r") do |f|
  sum = 0
  f.each_line do |line|
    array = line.chars.filter { |char| /[0-9]/.match char}
    combined = array.first + array.last
    sum += combined.to_i
  end

puts sum.inspect
end