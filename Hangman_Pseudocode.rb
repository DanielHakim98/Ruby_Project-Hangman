#PUTS "Start game"
#PUTS "Select to 1) or 2)"
#PUTS "1) Start new game"
#PUTS "2) Load game"
#INPUT selection

#IF selection NOT 1 OR 2, LOOP until INPUT selection == 1 OR selection == 2

#IF selection == 2, check if save game exist or not.
#IF not, PUTS "No saved game" and return back to menu.

#IF selection == 1, SET words = ["three", "seven", "eight"]
#(alternative) SET words = { 3 => "three", 7 => "seven" , 8 => "eight" }
#Select random element from words and SET selected = words
#LOOP until words.length-1 (if starts with 0), PRINT "_"
#PUTS "Guess the letter, you have 10 chances"
#INPUT guess
#LOOP until words.length-1, check if guess == element IN words.
