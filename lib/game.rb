# frozen_string_literal: true

# This class manages the overall flow of the game, handles turns, and coordinates between the codemaker and codebreaker.

require_relative 'codemaker'
require_relative 'codebreaker'
require_relative 'boarddisplay'

class Game
  attr_reader :board, :codemaker, :codebreaker

  MAX_TURNS = 8
  def initialize
    @board = BoardDisplay.new
    @codemaker = CodeMaker.new
    @codebreaker = CodeBreaker.new
    @max_turns = MAX_TURNS
    @current_turn = 1
    @game_won = false
  end

  def display_rules
    puts 'This is Mastermind, check the rules online'
  end

  def game_over?
    return false if @feedback_pegs.empty?

    black = @feedback_pegs.last[:black]

    @game_won = black == 4
    @game_won || @current_turn >= @max_turns
  end

  def display_game_result
    puts board.display
    if @game_won
      puts "🎉 Congratulations! You cracked the code in #{@current_turn} turns! 🎉"
    else
      puts '💔 Game Over. You ran out of turns.'
    end
  end

  def play
    # The Codemaker sets the secret code first
    @codemaker.generate_code
    p CodeMaker::COLORS
    display_rules
    guess = nil

    loop do
      puts "\n--- Turn #{@current_turn} ---"
      @board.display

      loop do
        guess = @codebreaker.make_guess
        break if @codebreaker.valid_guess?(guess)
      end
      @feedback_pegs = @codemaker.provide_feedback(guess)
      @board.add_turn(guess, @feedback_pegs)
      break if game_over?

      @current_turn += 1
    end
    display_game_result
  end
end
