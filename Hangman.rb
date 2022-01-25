#-----Read File from 5desk.txt and filter words-----#
require 'json'

class WordGenerator
  attr_reader :file_name, :loaded_txt, :selected_word,
              :missing_uniq_letters, :corrupt_selected_word

  def initialize(file_name)
    @file_name = file_name
    @loaded_txt = load_the_file()
    @selected_word = word_sample()
    @missing_uniq_letters = selected_letters()
    @corrupt_selected_word = WordGenerator.guess_this(@selected_word, @missing_uniq_letters)
  end

  def load_the_file()
    from_file = Array.new
    File.foreach(@file_name) do|line|
      line=line.chomp.downcase
      if line.length >= 3 and line.split('').uniq.length >= 3
        from_file.push(line.chomp)
      end
    end
    from_file
  end

  def word_sample()
    @loaded_txt.sample.split('')
  end

  def selected_letters()
    missing_uniq_letters = []
    uniq_letters = @selected_word.uniq
    3.times do
      uniq_letters=uniq_letters.shuffle
      missing_uniq_letters.push(uniq_letters.pop)
    end
    missing_uniq_letters
  end

  def self.guess_this(selected_word,missing_uniq_letters)
    corrupt_selected_word = selected_word.clone
    selected_word.each_with_index do |letter,idx|
      next if missing_uniq_letters.none?(letter)
      corrupt_selected_word[idx] = "_"
    end
    corrupt_selected_word
  end
end


class JsonSerialize
  def initialize(selected_word, missing_uniq_letters, corrupt_selected_word,i)
    @selected = selected_word
    @missing = missing_uniq_letters
    @corrupt = corrupt_selected_word
    @loop_index = i
    save_to_json()
  end

  def save_to_json()
    hash = {
      "selected"=>@selected,
      "missing"=>@missing,
      "corrupt"=>@corrupt,
      "loop_i"=>@loop_index
    }
    Dir.mkdir('save_file') unless Dir.exist?('save_file')
    File.open("save_file/save.json",'w') do |f|
      f.write(hash.to_json)
    end
  end
end

# #-----Guess the missing letters-----#
class GameStarted
  def initialize(obj1,obj2,x,y,z,i=0)
    @word_generator = obj1
    @save_generator = obj2
    @selected_word = x
    @missing_uniq_letters = y
    @corrupt_selected_word = z
    @loop_index = i.to_i
    puts @loop_index
    start()
  end

  def start()
    guess = ""
    num = 5-@loop_index
    num.times do |i|
      break if @missing_uniq_letters.length == 0
      puts "\n#{num-i} try remaining!"
      puts @corrupt_selected_word.join(' ')
      print "\nPlease enter the correct letter: "
      guess = gets.chomp.downcase
      if guess == '1'
        save_file = JsonSerialize.new(@selected_word,
                                      @missing_uniq_letters,
                                      @corrupt_selected_word,
                                      i)
        break
      elsif @missing_uniq_letters.any?(guess)
        puts "Correct guess"
        @missing_uniq_letters.delete(guess)
        @corrupt_selected_word =
        WordGenerator.guess_this(@selected_word,@missing_uniq_letters)
      else
         puts "WRONG"
      end
    end
    unless guess != '1'
      puts "\nGame progress has been saved.........."
      return
    end
    puts GameStarted.final_result(@missing_uniq_letters, @selected_word)
  end

  private
  def self.final_result(missing_uniq_letters, selected_word)
    return missing_uniq_letters.length != 0 ?
    "LOSERRRR...The word is #{selected_word.join}.":
    "You are correct. It's #{selected_word.join}"
  end
end


