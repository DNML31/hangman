class Word
  def initialize(word, spaces)
    @word = word
    @spaces = spaces
  end

  def make_blank_spaces
    @spaces.times do
      print "_ "
    end
  end

  def set_up
    make_blank_spaces
  end
end

open_txt = File.open('google-10000-english-no-swears.txt')
open_txt = open_txt.readlines(chomp: true) # array

word = open_txt.sample

until word.length >= 5 && word.length <= 12 do
  word = open_txt.sample
end

word_spaces = word.length
guess_this_word = Word.new(word, word_spaces)

def play_game(secret_word)

  letters = Range.new('a','z').to_a
  numbers = Range.new('0','9').to_a
  # want it to say this message and show blank spaces underneath
  print "\nLet's play hangman! Guess a letter:  "

  secret_word
  # method creates the blanks above the greeting message

  guess = gets.chomp

  if numbers.include?(guess)
    puts "not a letter"
    until letters.include?(guess) do
      puts "Choose a letter."
      guess = gets.chomp
    end

  elsif guess.length > 1
    until guess.length == 1 do
      puts "Choose only one letter."
      guess = gets.chomp

      until letters.include?(guess) do
        puts "Choose a letter."
        guess = gets.chomp
      end
    end

  else
    puts "checking..."
    # insert check method (needs to re-display current state of the game
  end
end

play_game(guess_this_word.set_up)