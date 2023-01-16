new_word = File.open('google-10000-english-no-swears.txt')

# word_bank = []
# # create new, blank array

# # until it gets to the end of the doc, keep adding words
# until new_word.eof? do
#   word_bank.push(new_word.gets.chomp)
# end

# # get a random word from the word_bank array
# p word_bank.sample

####

new_word = new_word.readlines(chomp: true)
# readlines parses all lines in file into an array
# chomp: true parameter removes "\n" from each line
p new_word.sample


# check the readlines method - pretty much does this same thing
# "The readlines method draws in all the content and automatically parses 
#it as an array, splitting the file contents by the line breaks."

# displays full content of the File object above

# need to select one random word from the file