# lib/connect_four.rb
# frozen_string_literal: true

require_relative 'board.rb'

# instantiates games of connect four
class ConnectFour < Board
  attr_reader :token_a, :token_b

  def initialize
    super
    @token_a = "\u26AB"
    @token_b = "\u26AA"
  end

  def victory?
    all_arrays.any? { |ary| four_connected?(ary) }
  end

  def four_connected?(array)
    pivot = array.shift
    count = 1
    until array.empty?
      first = array.shift
      first == pivot ? (count += 1 unless first.nil?) : count = 1
      break if count == 4

      pivot = first
    end
    return true if count == 4

    false
  end
end
