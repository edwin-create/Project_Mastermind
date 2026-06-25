# frozen_string_literal: true

# This class is responsible for managing the display of the game board.
# It handles rendering the current state, updating cells, etc.
class BoardDisplay
  attr_reader :history

  def initialize
    @history = []
  end

  def add_turn(guess, feedback)
    @history.clear.push(guess: guess, feedback: feedback)
  end

  def display
    puts "\nCurrent Board:"
    puts '-------------------------'
    puts @history
  end
end
