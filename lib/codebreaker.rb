# frozen_string_literal: true

# This class manages the human interaction for making a guess.

class CodeBreaker
  attr_reader :guess

  def initialize
    @guess = []
  end

  def make_guess
    valid_colors = %w[red blue green yellow purple]
    loop do
      puts "Enter your guess (4 colors separated by spaces: #{valid_colors.join(', ')}):"
      input = gets.chomp.split(' ') # Capture input, split into an array immediately

      if valid_guess?(input)
        @guess = input
        return @guess # Exit the loop and return the valid array of colors
      end
      # If the guess is invalid, the loop repeats automatically
    end
  end

  def valid_guess?(guess)
    valid_colors = %w[red blue green yellow purple]
    if guess.length != 4
      puts 'Invalid guess: You must enter exactly 4 colors.'
      false
    elsif guess.any? { |color| !valid_colors.include?(color) }
      puts "Invalid guess: Colors must be one of #{valid_colors.join(', ')}."
      false
    else
      true
    end
  end
end
