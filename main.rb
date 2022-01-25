require_relative "Hangman"

file_name = "5desk.txt"
puts "------Hangman-------"
puts "Select Either one: "
puts "1) New Game"
puts "2) Load Game"
print "Input: "
option = gets.chomp
if option == '1'
  word_generator1 = WordGenerator.new(file_name)
  x = word_generator1.selected_word
  y = word_generator1.missing_uniq_letters
  z = word_generator1.corrupt_selected_word
elsif option == '2'
  read_file = File.read('save_file/save.json')
  data_hash = JSON.parse(read_file)
  x = data_hash['selected']
  y = data_hash['missing']
  z = data_hash['corrupt']
  i = data_hash['loop_i']
  puts i
else
  puts "\ninvalid INPUT"
end

game1 = GameStarted.new(WordGenerator,JsonSerialize,x,y,z,i)