require 'yaml'

class Word
  attr_reader :word, :spaces

  def initialize(word, spaces)
    @word = word
    @spaces = spaces
  end

  def blank_spaces
    @spaces.times do print('_ ') end
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

print "************************"
puts "\nLet's play hangman! You will have 10 tries to figure out the word.
\nInput only ONE alphabetical letter per turn (no numbers or symbols).\n\n"

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

game_hash = {
  word: '',
  word_spaces: '',
  spaces: '',
  spaces_array: '',
  tries: '',
  correct_letters: '',
  wrong_letters: '',
}

word_array = word.split(//)
spaces_array = []
tries = 10
correct_letters = []
wrong_letters = []
spaces.times do spaces_array.push("-") end

def play_game(word, word_spaces, word_array, spaces, spaces_array, tries, 
  correct_letters, wrong_letters, game_hash)

  letters = Range.new('a','z').to_a
  numbers = Range.new('0','9').to_a

  while tries > 0 || word_array != spaces_array do
    print "\n* To save this game type 'save'."
    print "\n** To load a previous game type 'load'."
    print "\nTries left: #{tries}. Guess a letter:  "
    guess = gets.chomp

    if guess == 'save'

      game_hash[:word] = word
      game_hash[:spaces] = spaces
      game_hash[:correct_letters] = correct_letters
      game_hash[:wrong_letters] = wrong_letters
      game_hash[:tries] = tries

      puts "This game will be saved to continue later."
      puts 'what is the filename?'
      x = gets.chomp
      File.open("#{x}.yaml", 'w+x') {|save_file| save_file.write(game_hash)}
      break

    elsif guess == 'load'
      # having issue with loading text from saved file
      # previously saved file not loaded, new game gets puts
      puts 'filename?'
      y = gets.chomp
      open_file = File.open("#{y}.yaml", 'r')
      load_hash = open_file.readlines
      puts load_hash[:word]
      # play_game(load_hash[:word], load_hash[:word_spaces].to_i, load_hash[:word_array],
      #   load_hash[:spaces].to_i, load_hash[:spaces_array], load_hash[:tries].to_i, 
      #   load_hash[:correct_letters], load_hash[:wrong_letters])
      # at the end of 'load', start at the loop (line 91)
    end

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

play_game(solve_me.word, solve_me.blank_spaces, word_array, 
  solve_me.spaces, spaces_array, tries, correct_letters, wrong_letters, game_hash)

