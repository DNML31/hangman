require 'yaml'

class Game
  attr_reader :word, :spaces
  attr_accessor :tries, :correct_letters, :wrong_letters

  def initialize(word, spaces)
    @word = word
    @spaces = spaces
    @tries = 10
    @correct_letters = []
    @wrong_letters = []
  end

  def save(obj)
    puts 'saving...'
    puts 'Current game will be saved to play later.'
    puts 'What will this game be called?'
    x = gets.chomp
    File.open("#{x}.yaml", 'w+x') { |save| save.write(obj.to_yaml) }
  end

  def load
    puts 'File name?'
    x = gets.chomp
    File.open("#{x}.yaml", 'r')
  end
end

open_txt = File.open('google-10000-english-no-swears.txt')
open_txt = open_txt.readlines(chomp: true) # array
word = open_txt.sample
until word.length >= 5 && word.length <= 12 do
  word = open_txt.sample
end

spaces = word.length

game_obj = Game.new(word, spaces)

def check_guess(game_obj, guess)
  word = game_obj.word.split(//)
  print "\n**********\n"

  if word.include?(guess)
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
  letters = Range.new('a', 'z').to_a
  numbers = Range.new('0', '9').to_a

  word_array = game_obj.word.split(//)

  spaces_array = []
  game_obj.spaces.times do
    spaces_array.push("_")
  end

  while game_obj.tries > 0 || word_array != spaces_array do

    word_array.each_with_index do |element, index|
      if game_obj.correct_letters.uniq.include?(element)
        spaces_array[index] = element
      end
    end

    puts spaces_array.join('')
    puts "\nincorrect letters - #{game_obj.wrong_letters.uniq.join(' ')}"

    print "\n* To save this game type 'save'."
    print "\n** To load a previous game type 'load'."
    print "\nTries left: #{game_obj.tries}. Guess a letter:  "
    guess = gets.chomp

    if guess == 'save'
      game_obj.save(game_obj)
      break
    end

    if guess == 'load'
      puts 'File name?'
      x = gets.chomp
      file = Psych.unsafe_load(File.open("#{x}.yaml", 'r'))
      play_game(file)
      break
    end

    while game_obj.correct_letters.include?(guess) || 
      game_obj.wrong_letters.include?(guess)

      puts "\nYou've already guessed this letter. Try another: "
      guess = gets.chomp
    end

    if numbers.include?(guess)
      puts 'Not a letter...'
      until letters.include?(guess) do
        puts 'Choose a letter: '
        guess = gets.chomp
      end
    elsif guess.length > 1
      until guess.length == 1 do
        puts 'Choose only ONE letter.'
        guess = gets.chomp

        until letters.include?(guess) do
          puts 'Choose a letter.'
          guess = gets.chomp
        end
      end

    else
      check_guess(game_obj, guess)
    end

    if word_array.include?(guess)
      game_obj.correct_letters.push(guess)

      word_array.each_with_index do |element, index|
        if element == guess
          spaces_array[index] = guess
        end
      end
    elsif word_array.none?(guess)
      game_obj.tries -= 1
      game_obj.wrong_letters.push(guess)
    end

    if game_obj.tries == 0
      puts "You lose. The word was #{word_array.join('').upcase}."
      break
    elsif word_array == spaces_array
      puts 'You win! You solved the word!'
      break
    end

  end
end

print '************************'
puts "\nLet's play hangman! You will have 10 tries to figure out the word.
\nInput only ONE alphabetical letter per turn (no numbers or symbols).\n\n"

play_game(game_obj)
