loaded_txt = Array.new
File.foreach("5desk.txt") do|line|
  line=line.chomp.downcase
  if line.length >= 3 and line.split('').uniq.length >= 3
    loaded_txt.push(line.chomp)
  end
end
#puts loaded_txt.length--------------check total of loaded words

selected_word = loaded_txt.sample.split('')
uniq_letters = selected_word.uniq
missing_uniq_letters = []

3.times do
  uniq_letters=uniq_letters.shuffle
  #puts "uniq_letters: #{uniq_letters}"--------------show the uniq letters
  missing_uniq_letters.push(uniq_letters.pop)
  #puts "Missing uniq_letters: #{missing_uniq_letters}"--------------show the missing letters
end

puts puts

def guess_this(selected_word,missing_uniq_letters)
  corrupt_selected_word = selected_word.clone
  selected_word.each_with_index do |letter,idx|
    next if missing_uniq_letters.none?(letter)
    corrupt_selected_word[idx] = "_"
  end
  corrupt_selected_word
end

corrupt_selected_word = guess_this(selected_word,missing_uniq_letters)

5.times do
  break if missing_uniq_letters.length == 0
  puts corrupt_selected_word.join(' ')
  puts "\nPlease enter the correct letter."
  guess = gets.chomp.downcase
  if missing_uniq_letters.any?(guess)
    puts "Correct guess"
    missing_uniq_letters.delete(guess)
    #p missing_uniq_letters--------------check the remaining missing uniq_letters
    corrupt_selected_word = guess_this(selected_word,missing_uniq_letters)
  else
    puts "WRONG"
  end
end

if missing_uniq_letters.length != 0
  puts "LOSERRRR...The word is #{selected_word.join}."
else
  puts "You are correct. It's #{selected_word.join}"
end



