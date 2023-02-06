require 'yaml'

class Game
  attr_reader :word, :spaces
  attr_accessor :tries, :save_hash

  def initialize(word, spaces, save_hash)
    @word = word
    @spaces = spaces
    @tries = 10

    @save_hash = {
      :word => @word,
      :spaces => @spaces,
      :tries => @tries,
      :correct_letters => [],
      :wrong_letters=> [],
    }
    puts "#{@save_hash}"
  end

  def save(hash_obj)
    puts "saving..."
    YAML.dump File.new(hash_obj)
  end

  def load(yaml_hash)
    puts "loading..."
    x = YAML.load(yaml_hash)
    puts x
  end

end

open_txt = File.open('google-10000-english-no-swears.txt')
open_txt = open_txt.readlines(chomp: true) # array
word = open_txt.sample
until word.length >= 5 && word.length <= 12 do
  word = open_txt.sample
end

spaces = word.length

game_hash = {
  word: '',
  spaces: '',
  tries: '',
  correct_letters: '',
  wrong_letters: '',
}

game_obj = Game.new(word, spaces, game_hash)

def check_guess(game_obj, guess)

  word = game_obj.word.split(//)
  # array

  if word.include?(guess)
    print "\n**********\n"
    puts "\nCORRECT.\n"
    word.each_with_index do |element, index|
      if element == guess
        word[index] = guess
      end
    end
  else
    print "\n**********\n"
    puts "\nINCORRECT. TRY AGAIN.\n"
  end
end

def play_game(game_obj)

  letters = Range.new('a','z').to_a
  numbers = Range.new('0','9').to_a

  word_array = game_obj.word.split(//)
  spaces_array = []
  game_obj.spaces.times do
    spaces_array.push("_ ")
  end

  while game_obj.tries > 0 || word_array != spaces_array do

    puts spaces_array.join(' ')
    puts "\nincorrect letters - #{game_obj.save_hash[:wrong_letters].uniq.join(' ')}"


    print "\n* To save this game type 'save'."
    print "\n** To load a previous game type 'load'."
    print "\nTries left: #{game_obj.tries}. Guess a letter:  "
    guess = gets.chomp

    if guess == 'save'
      ###
    end  

    if guess == 'load'
      ###
    end

    while game_obj.save_hash[:correct_letters].include?(guess) || 
      game_obj.save_hash[:wrong_letters].include?(guess)

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
      check_guess(game_obj, guess)
    end

    if word_array.include?(guess)
      puts ''
      game_obj.save_hash[:correct_letters].push(guess)
      # need to add 'guess' to a display
      # need to add 'guess' to an array to compare to word_array

    elsif word_array.none?(guess)
      game_obj.tries -= 1
      game_obj.save_hash[:wrong_letters].push(guess)
    end


    # loop condition
    if game_obj.tries == 0
      puts "You lose. The word was #{word_array.join('').upcase}."
      break
    elsif word_array == spaces_array
      puts "You win! You solved the word!"
      break
    end

  end
  # end loop

end

print "************************"
puts "\nLet's play hangman! You will have 10 tries to figure out the word.
\nInput only ONE alphabetical letter per turn (no numbers or symbols).\n\n"

play_game(game_obj)