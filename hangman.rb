new_word = File.open('google-10000-english-no-swears.txt')

new_word = new_word.readlines(chomp: true)
word = new_word.sample

until word.length >= 5 && word.length <= 12 do
  word = new_word.sample
end
p word

word_length = word.length
p word_length
