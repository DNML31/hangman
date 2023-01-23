class Word
  attr_reader :word
  attr_reader :spaces

  def initialize(word, spaces)
    @word = word
    @spaces = spaces
  end

  def blank_spaces
    @spaces.times do print "_ " end
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
  print (word.to_a.index {|element| element == guess})
end

def change_spaces(spaces, word, guess)

  word.each_with_index do |letter, index|
    if letter == guess
      spaces[index] = guess
    end
  end
  print spaces.join(' ')

end

def play_game(word, word_spaces, spaces)
  letters = Range.new('a','z').to_a
  numbers = Range.new('0','9').to_a

  tries = 10

  word_array = word.split(//)

  # p word_spaces
  p word_array

  print "\nLet's play hangman! Guess a letter:  "
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

  spaces_array = []
  spaces.times do spaces_array.push("-") end

  if word_array.include?(guess)
    puts 'correct'
    change_spaces(spaces_array, word_array, guess)

  else
    puts 'incorrect'

    tries -= 1
    print tries

    until tries == 0
      play_game(word, word_spaces, spaces)
    end
    # if incorrect letter, display a message
    # -= number of guesses left
    # repeat guess sequence
  end

end

play_game(solve_me.word, solve_me.blank_spaces, solve_me.spaces)