words = ["three", "seven", "eight"]
sample = words.sample.split('')
letters = sample.uniq
missing_letters = []

3.times do
  letters=letters.shuffle
  puts "Letters: #{letters}"
  missing_letters.push(letters.pop)
  puts "Missing letters: #{missing_letters}"
end

puts puts

def guess_this(sample,missing_letters)
  corrupt_sample = sample.clone
  sample.each_with_index do |letter,idx|
    next if missing_letters.none?(letter)
    corrupt_sample[idx] = "_"
  end
  corrupt_sample
end

corrupt_sample = guess_this(sample,missing_letters)

5.times do
  p corrupt_sample
  puts "Please enter the correct letter."
  guess = gets.chomp
  if missing_letters.any?(guess)
    puts "Correct guess"
    missing_letters.delete(guess)
    p missing_letters
    corrupt_sample = guess_this(sample,missing_letters)
  else
    puts "WRONG"
  end
end




