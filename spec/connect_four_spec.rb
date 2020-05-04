# spec/connect_four_spec.rb
# frozen_string_literal: true

require 'connect_four.rb'

describe ConnectFour do
  subject { ConnectFour.new }

  describe 'sets conditions' do
    it 'player 0 as ⚫' do
      expect(subject.token0).to eql('⚫')
    end

    it 'player 1 as ⚪' do
      expect(subject.token1).to eql('⚪')
    end

    it 'player 0 to start' do
      expect(subject.next_player).to eql(0)
    end

    it 'verticals to be 7 arys à 6 x nil' do
      expect(subject.verticals).to eql(Array.new(7, Array.new(6, nil)))
    end
  end

  describe 'recognizes four consecutives !=nil in an array, expect:' do
    describe '#four_connected?' do
      array0 = Array.new(7, nil)
      array1 = Array.new(7, 'a')
      array3 = [*%w[a a a], nil, *%w[b b b]]
      array4 = [*%w[b a b a], nil, *%w[b a]]
      array5 = %w[b a b a b a b a]
      array7 = [*%w[a a a], nil, *%w[a a]]
      array8 = [*%w[a a a], nil, *%w[a a a]]
      array2 = [*%w[a a a], nil, *%w[a a a a]]
      array9 = %w[a a a b a a a b]
      array10 = %w[a a a a b a a b]
      array11 = %w[b a a a a b a]
      array12 = %w[a a a b a a a a]
      array13 = %w[a a b a a a a]
      array14 = [nil, nil, nil, nil, *%w[a a a a]]
      array15 = [nil, 'a', nil, *%w[a a a]]
      array16 = [nil, 'b', nil, *%w[b b b]]
      array17 = [*%w[b b b], nil, *%w[a a a]]
      array18 = [*%w[b b b], nil, *%w[b b b b]]
      array19 = [*%w[b b b b], nil, *%w[a a a]]
      array20 = [nil, 'b', nil, *%w[b b b b]]
      array22 = [nil, nil, nil, nil, *%w[b b b b]]
      array23 = [nil, nil, nil, nil, *%w[b b b]]
      it { expect(subject.four_connected?(array0)).not_to be true }
      it { expect(subject.four_connected?(array1)).to be true }
      it { expect(subject.four_connected?(array3)).not_to be true }
      it { expect(subject.four_connected?(array4)).not_to be true }
      it { expect(subject.four_connected?(array5)).not_to be true }
      it { expect(subject.four_connected?(array7)).not_to be true }
      it { expect(subject.four_connected?(array8)).not_to be true }
      it { expect(subject.four_connected?(array2)).to be true }
      it { expect(subject.four_connected?(array9)).not_to be true }
      it { expect(subject.four_connected?(array10)).to be true }
      it { expect(subject.four_connected?(array11)).to be true }
      it { expect(subject.four_connected?(array12)).to be true }
      it { expect(subject.four_connected?(array13)).to be true }
      it { expect(subject.four_connected?(array14)).to be true }
      it { expect(subject.four_connected?(array15)).not_to be true }
      it { expect(subject.four_connected?(array16)).not_to be true }
      it { expect(subject.four_connected?(array17)).not_to be true }
      it { expect(subject.four_connected?(array18)).to be true }
      it { expect(subject.four_connected?(array19)).to be true }
      it { expect(subject.four_connected?(array20)).to be true }
      it { expect(subject.four_connected?(array22)).to be true }
      it { expect(subject.four_connected?(array23)).not_to be true }
    end
  end

  describe 'creation and testing of and across all possible arrays' do
    context 'with default new_verticals' do
      it 'returns victory? to be false' do
        expect(subject.victory?).to be false
      end
      it 'returns board_overload? to be false' do
        expect(subject.board_overload?).to be false
      end
      it 'returns game_over? to be false' do
        expect(subject.game_over?).to be false
      end
    end

    context 'with test array 1 as verticals' do
      before(:each) do
        subject.verticals =
          [[0, 7, 14, 21, 28, 35],
           [1, 8, 15, 22, 29, 36],
           [2, 9, 16, 23, 30, 37],
           [3, 10, 17, 24, 31, 38],
           [4, 11, 18, 25, 32, 39],
           [5, 12, 19, 26, 33, 40],
           [6, 13, 20, 27, 34, 41]]
      end
      it 'sums up to 25 uniq arrays' do
        expect(subject.all_arrays.uniq.size).to eql(25)
      end
      it 'returns victory? to be false' do
        expect(subject.victory?).to be false
      end
      it 'returns board_overload? to be true' do
        expect(subject.board_overload?).to be true
      end
      it 'returns game_over? to be true' do
        expect(subject.game_over?).to be true
      end
    end

    context 'with test array 2 as verticals' do
      before(:each) do
        subject.verticals =
          [[0, 7, 14, 21, 28, 35],
           [1, 8, 15, 22, 29, 36],
           [2, 9, 16, 23, 30, 37],
           [3, 10, 17, 24, 31, 38],
           [4, 11, 18, 25, 32, 39],
           [5, 12, 19, 26, 33, nil],
           [6, 13, 20, 27, 34, 41]]
      end
      it 'returns victory? to be false' do
        expect(subject.victory?).to be false
      end
      it 'returns board_overload? to be false' do
        expect(subject.board_overload?).to be false
      end
      it 'returns game_over? to be false' do
        expect(subject.game_over?).to be false
      end
    end

    context 'with test array 2 as verticals' do
      before(:each) do
        subject.verticals =
          [[0, 7, 14, 21, 28, 35],
           [1, 0, 15, 22, 29, 36],
           [2, 9, 0, 23, 30, 37],
           [3, 10, 17, 0, 31, 38],
           [4, 11, 18, 25, 32, 39],
           [5, 12, 19, 26, 33, nil],
           [6, 13, 20, 27, 34, 41]]
      end
      it 'returns victory? to be true' do
        expect(subject.victory?).to be true
      end
      it 'returns board_overload? to be false' do
        expect(subject.board_overload?).to be false
      end
      it 'returns game_over? to be true' do
        expect(subject.game_over?).to be true
      end
    end
  end
end
