class Word
  attr_reader :word
  attr_reader :spaces

  def initialize(word, spaces)
    @word = word
    @spaces = spaces
  end

  def blank_spaces
    @spaces.times do print('_') end
  end
end

print "************************"
puts "\nLet's play hangman! You will have 10 tries to figure out the mystery word.
\nInput only ONE alphabetical letter per turn (no numbers or symbols).\n\n"

open_txt = File.open('google-10000-english-no-swears.txt')
open_txt = open_txt.readlines(chomp: true) # array
word = open_txt.sample
until word.length >= 5 && word.length <= 12 do
  word = open_txt.sample
end

spaces = word.length
solve_me = Word.new(word, spaces)

def check_guess(spaces_array, word_array, guess)

  wrong_letters = []

  if word_array.include?(guess)
    print "**********"
    puts "\nCorrect."

    word_array.each_with_index do |letter, index|
      if letter == guess
        spaces_array[index] = guess
      end
    end

  else
    wrong_letters.push(guess)
    print "**********"
    puts "\nIncorrect. Try again."
    puts "\nAlready guessed letters - #{wrong_letters.join(' ')}\n"

  end

  result = spaces_array.join('')
  print result
  # print result.class

end

def play_game(word, word_spaces, spaces)
  letters = Range.new('a','z').to_a
  numbers = Range.new('0','9').to_a
  word_array = word.split(//)

  p word_array
  # ["w", "o", "r", "d"]

  spaces_array = []
  spaces.times do spaces_array.push("-") end
    # ["-", "-", "-", "-"]

    # loop starting from here...
  loop do
    tries = 10
    print "\n\nTries left: #{tries}. Guess a letter:  "
    # need to remember ALL already guessed letters
    guess = gets.chomp

    if numbers.include?(guess)
      puts "Not a letter..."

      until letters.include?(guess) do
        puts "Choose a letter: "
        guess = gets.chomp
      end

    elsif guess.length > 1

      until guess.length == 1 do
        puts "Choose only ONE letter."
        guess = gets.chomp

        until letters.include?(guess) do
          puts "Choose a letter."
          guess = gets.chomp
        end
      end

    else
      current = check_guess(spaces_array, word_array, guess)
      print current.to_s
      # current is a Nilclass - all referneces to this var are not working
      # print word_array.join('')
    end

    if word.include?(guess)
      puts "don't decrement"
    elsif word.split.none?(guess)
      puts "decrement"
      # print tries -= 1
      # decrement won't continue
    end

    # loop condition
    if tries == 0
      break
    elsif word_array.to_s == current.to_s
      break
    end

  end
  # ...to here...

end

play_game(solve_me.word, solve_me.blank_spaces, solve_me.spaces)