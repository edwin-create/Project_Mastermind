# frozen_string_literal: true

# # This class is responsible for managing the display of the game board.
# It handles rendering the current state, updating cells, etc.

class BoardDisplay
  attr_reader :history

  def initialize
    @history = []
  end

  def add_turn(guess, feedback)
    @history.push(guess: guess, feedback: feedback)
  end

  def display
    puts "\nCurrent Board:"
    @history.each_with_index do |turn, index|
      guess = turn[:guess].join(', ')
      feedback = turn[:feedback].map { |f| "Black: #{f[:black]}, White: #{f[:white]}" }.join(' | ')
      puts "Turn #{index + 1}: Guess: [#{guess}] => Feedback: [#{feedback}]"
    end
  end
end
