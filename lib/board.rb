# lib/board.rb
# frozen_string_literal: true

# provides all necessary and possible arrays to
# control a standard 7x6 game of 'connect four'
# provides methods to log the current status of the game to the console
class Board
  attr_accessor :verticals

  def initialize
    @verticals = new_verticals
  end

  def print_grid
    print "\n\n _______________ \n"
    6.times do |i|
      puts "| #{horizontals[5 - i].map { |n| n.nil? ? ' ' : n }.join(' ')} |"
    end
    puts '| ─ ─ ─ ─ ─ ─ ─ |'
    puts "| 0 1 2 3 4 5 6 |\n\n"
  end

  def new_verticals
    verticals = []
    7.times do
      new_ary = []
      6.times do
        new_ary << nil
      end
      verticals << new_ary
    end
    verticals
  end

  def all_arrays
    verticals + horizontals + diagonals(asc) + diagonals(desc)
  end

  # creates a deep copy of the current state
  # for the destructive 'four_connected?' checkup
  def all_arrays_clone
    all_arrays.dup.map(&:dup)
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

  def row(column)
    nils = verticals[column].count(nil)
    nils.zero? ? false : 6 - nils
  end

  def horizontals
    verticals.transpose
  end

  def diagonals(proc)
    proc.call(diagonals = [])
    diagonals.select { |ary| ary.size > 3 }
  end

  def desc
    @desc = proc do |diagonals|
      -6.upto(5) do |i|
        ary = []
        6.downto(0) do |j|
          ary << verticals[j][i]
          i += 1
        end
        diagonals << (i < 7 ? ary[-i..-1] : ary[0..-i + 12])
      end
    end
  end

  def asc
    @asc = proc do |diagonals|
      5.downto(-6) do |i|
        ary = []
        0.upto(6) do |j|
          ary << verticals[j][i]
          i += 1
        end
        diagonals << (i < 7 ? ary[-i..-1] : ary[0..-i + 12])
      end
    end
  end
end
