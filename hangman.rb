class Word
  attr_reader :word
  attr_reader :spaces

  def initialize(word, spaces)
    @word = word
    @spaces = spaces
  end

  def blank_spaces
    @spaces.times do print('_ ') end
  end
end

print "************************"
puts "\nLet's play hangman! You will have 10 tries to figure out the word.
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
  # ( [-,-,-,-], [t,e,s,t], "t")
  
  if word_array.include?(guess)
    print "\n**********\n"
    puts "\nCORRECT.\n"

    word_array.each_with_index do |letter, index|
      if letter == guess
        spaces_array[index] = guess
      end
    end

  else
    print "\n**********\n"
    puts "\nINCORRECT. TRY AGAIN.\n"
  end

  result = spaces_array.join(' ')
  print result.to_s

end

def play_game(word, word_spaces, spaces)
  # ("test", _ _ _ _ , 4)

  letters = Range.new('a','z').to_a
  numbers = Range.new('0','9').to_a
  word_array = word.split(//)

  spaces_array = []
  spaces.times do spaces_array.push("-") end

  tries = 10

  correct_letters = []
  wrong_letters = []

  loop do
    print "\nTries left: #{tries}. Guess a letter:  "
    guess = gets.chomp

    while correct_letters.include?(guess) || wrong_letters.include?(guess)
      puts "\nYou've already guessed this letter. Try another: "
      guess = gets.chomp
    end

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
      check_guess(spaces_array, word_array, guess)
    end

    if word.include?(guess)
      puts ''
      correct_letters.push(guess)
    elsif word.split.none?(guess)
      tries -= 1
      wrong_letters.push(guess)
    end

    puts "\n\nincorrect letters - #{wrong_letters.uniq.join(' ')}"

    # loop condition
    if tries == 0
      puts "You lose. The word was #{word_array.join('').upcase}."
      break
    elsif word_array == spaces_array
      puts "You win! You solved the word!"
      break
    end

  end
  # end loop

end

play_game(solve_me.word, solve_me.blank_spaces, solve_me.spaces)