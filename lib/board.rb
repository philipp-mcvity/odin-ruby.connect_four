# lib/board.rb
# frozen_string_literal: true

# grid and grid control for 'connect four'
class Board
  attr_accessor :verticals

  def initialize
    @verticals = new_verticals
  end

  def new_verticals
    Array.new(7, Array.new(6, nil))
  end

  def all_arrays
    verticals + horizontals + diagonals(asc) + diagonals(desc)
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
