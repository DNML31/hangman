class Word
  def initialize(word, spaces)
    @word = word
    @spaces = spaces
  end

  # create blank spaces and an array of blank spaces
  def blank_spaces
    spaces = []
    @spaces.times do
      spaces.push("_ ")
      print "_ "
    end
  end

  # return the word
  def word
    @word
  end

end

open_txt = File.open('google-10000-english-no-swears.txt')
open_txt = open_txt.readlines(chomp: true) # array
word = open_txt.sample
until word.length >= 5 && word.length <= 12 do
  word = open_txt.sample
end

spaces = word.length
solve_me = Word.new(word, spaces)

def find_index(guess, word)
  print word.to_a.index {|element| element == guess}
  # get the WORD and turn it into an array
  # find the index where the GUESS is in the WORD array
  # return the index number

end

def play_game(word, word_spaces)
  p word_spaces
  p word
  letters = Range.new('a','z').to_a
  numbers = Range.new('0','9').to_a
  word_array = word.split(//)

  print "\nLet's play hangman! Guess a letter:  "
  guess = gets.chomp

  # user guess filtering for valid input
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

  if word_array.include?(guess)
    puts 'correct'

    find_index(guess, word_array)
    # this method returns the index of the word_array where the guess is
  else
    puts 'incorrect'
    # if incorrect letter, display a message
    # -= number of guesses left
    # repeat guess sequence
  end

end

play_game(solve_me.word, solve_me.blank_spaces)