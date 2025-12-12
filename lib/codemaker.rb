# frozen_string_literal: true

# This class is responsible for generating and securely storing the secret code and providing feedback after each guess.

class CodeMaker
  attr_reader :secret_code, :feedback

  COLORS = %w[red blue green yellow purple].freeze

  def initialize
    @secret_code = []
    @feedback = []
  end

  def generate_code
    @secret_code = Array.new(4) { COLORS.sample }
    @secret_code
  end

  def provide_feedback(guess)
    white = 0
    black = 0

    secret_code_copy = @secret_code.dup
    guess_copy = guess.dup

    # --------------------------
    # Step 1: Count black matches
    # --------------------------
    4.times do |i|
      next unless guess_copy[i] == secret_code_copy[i]

      black += 1
      guess_copy[i] = nil            # mark as used
      secret_code_copy[i] = nil      # mark as used
    end

    # --------------------------
    # Step 2: Count white matches
    # --------------------------
    4.times do |i|
      next if guess_copy[i].nil? # skip already-matched items

      4.times do |j|
        next unless guess_copy[i] == secret_code_copy[j]

        white += 1
        secret_code_copy[j] = nil    # prevent double-counting
        break                        # stop searching after one match
      end
    end

    @feedback.clear.push(black: black, white: white)
    @feedback
  end
end
