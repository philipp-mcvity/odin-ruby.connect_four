# lib/connect_four.rb
# frozen_string_literal: true

require_relative 'board.rb'

# provides the methods to play games of 'connect four'
# on the corresponding board
class ConnectFour < Board
  attr_reader :token0, :token1, :player

  def initialize
    super
    @token0 = "\u26AB"
    @token1 = "\u26AA"
    @player = 1
  end

  def game
    print "\n\n *** NEW GAME ***"
    print_grid
    play
  end

  def play
    next_player
    user_drop
    print_grid
    evaluate
  end

  def evaluate
    if game_over?
      puts "Player #{player.zero? ? @token0 : @token1} wins!!\n\n" if victory?
      puts "Draw! Board is full.\n\n" if board_overload?
      ask_for_restart
    else
      play
    end
  end

  def user_drop
    column = pick_column
    until (row = row(column))
      puts 'Full! Choose another column!'
      column = pick_column
    end
    verticals[column][row] = (player.zero? ? @token0 : @token1)
  end

  def ask_for_restart
    return unless user_input(/^[yn]$/, restart) == 'y'

    initialize
    game
  end

  def pick_column
    user_input(/^[0-6]$/, drop_disc).to_i
  end

  def next_player
    @player = (player.zero? ? 1 : 0)
  end

  def game_over?
    victory? || board_overload?
  end

  def victory?
    all_arrays_clone.any? { |ary| four_connected?(ary) }
  end

  def board_overload?
    verticals.flatten.count(nil).zero? ? true : false
  end

  def user_input(regex, proc)
    print '> '
    loop do
      proc.call(player)
      input = gets.chomp
      input.match(regex) ? (return input) : print("\n> INVALID! ")
    end
  end

  def drop_disc
    @drop_disc = proc do |player|
      print "Player #{player.zero? ? @token0 : @token1} : Drop your disc!
  > 0 - 6: "
    end
  end

  def restart
    @restart = proc do
      print "Do you want to play again?
  > y / n: "
    end
  end
end
