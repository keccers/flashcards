# Main file for
class Flashcard
  attr_reader :term, :definition 
  def initialize(args)
    @term = args[:term]
    @definition = args[:definition]
  end
end

class Deck
  attr_reader :file
  attr_accessor :cards
  def initialize(file)
    @file = file
    @cards = []
  end

  def parse_file
    flashcards = File.read(file).split(/\n/).reject {|whitespace| whitespace == ""}
    flashcards.each_slice(2) do |definition, term|
      cards << Flashcard.new(Hash[definition: definition, term: term])
    end
    cards
  end

  def shuffle!
    cards.shuffle!
  end

  def show_card(index)
    cards[index].definition
  end

  def check_guess(guess, index)  
    if guess == cards[index].term
       puts "nice answer...still a muggle though."
       return true
    elsif guess == "help"
      puts "Enter 'skip' to move to the next card. Enter 'exit' to quit the program."
    elsif guess == "skip"
      puts "pansy..."
      return true 
    end 
  end

end

class Controller
  def run
    execute   
  end

  private

  def execute
    deck = Deck.new('flashcard_samples.txt')
    deck.parse_file
    deck.shuffle!
    @index = 0 
    puts "Welcome to Ruby Flash Cards. To play, just enter the correct term for each definition.  Ready?  Go!"
    game_loop(deck)
  end

  def game_loop(deck)
    while true
      puts "Definition:"
      puts deck.show_card(@index)
      puts "Guess:"
      guess = gets.chomp
      break if guess == 'exit'
       @index += 1 if deck.check_guess(guess, @index)
    end
  end

end

#TESTS
# deck = Deck.new('flashcard_samples.txt')
# deck.parse_file
# # puts deck.cards[1].term
# # #puts deck.cards[1].definition
# # # deck.shuffle
# # # puts deck.cards[1].term
# puts deck.check_guess?("and", 1)

#DRIVER
game = Controller.new
game.run
