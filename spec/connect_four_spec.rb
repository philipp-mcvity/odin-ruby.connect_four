# spec/connect_four_spec.rb
# frozen_string_literal: true

require 'connect_four.rb'

describe ConnectFour do
  subject { ConnectFour.new }

  describe 'represent tokens' do
    it 'for player A as ⚫' do
      expect(subject.token_a).to eql('⚫')
    end
    it 'for player B as ⚪' do
      expect(subject.token_b).to eql('⚪')
    end
  end

  describe 'recognizes four consecutives in an array (size < 9), expect:' do
    it "#{array0 = Array.new(7, nil)} to be false" do
      expect(subject.four_connected?(array0)).not_to be true
    end
    it "#{array1 = Array.new(7, 'a')} to be true" do
      expect(subject.four_connected?(array1)).to be true
    end
    it "#{array2 = Array.new(7, 'b')} to be true" do
      expect(subject.four_connected?(array2)).to be true
    end
    it "#{array3 = [*%w[a a a], nil, *%w[b b b]]} to be false" do
      expect(subject.four_connected?(array3)).not_to be true
    end
    it "#{array4 = [*%w[b a b a], nil, *%w[b a]]} to be false" do
      expect(subject.four_connected?(array4)).not_to be true
    end
    it "#{array5 = %w[b a b a b a b a]} to be false" do
      expect(subject.four_connected?(array5)).not_to be true
    end
    it "#{array6 = [*%w[a a a], nil, 'a']} to be false" do
      expect(subject.four_connected?(array6)).not_to be true
    end
    it "#{array7 = [*%w[a a a], nil, *%w[a a]]} to be false" do
      expect(subject.four_connected?(array7)).not_to be true
    end
    it "#{array8 = [*%w[a a a], nil, *%w[a a a]]} to be false" do
      expect(subject.four_connected?(array8)).not_to be true
    end
    it "#{array9 = %w[a a a b a a a b]} to be false" do
      expect(subject.four_connected?(array9)).not_to be true
    end
    it "#{array10 = %w[a a a a b a a b]} to be true" do
      expect(subject.four_connected?(array10)).to be true
    end
    it "#{array11 = %w[b a a a a b a]} to be true" do
      expect(subject.four_connected?(array11)).to be true
    end
    it "#{array12 = %w[a a a b a a a a]} to be true" do
      expect(subject.four_connected?(array12)).to be true
    end
    it "#{array13 = %w[a a b a a a a]} to be true" do
      expect(subject.four_connected?(array13)).to be true
    end
    it "#{array14 = [nil, nil, nil, nil, *%w[a a a a]]} to be true" do
      expect(subject.four_connected?(array14)).to be true
    end
    it "#{array15 = [nil, 'a', nil, *%w[a a a]]} to be false" do
      expect(subject.four_connected?(array15)).not_to be true
    end
    it "#{array16 = [nil, 'b', nil, *%w[b b b]]} to be false" do
      expect(subject.four_connected?(array16)).not_to be true
    end
    it "#{array17 = [*%w[b b b], nil, *%w[a a a]]} to be false" do
      expect(subject.four_connected?(array17)).not_to be true
    end
    it "#{array18 = [*%w[b b b], nil, *%w[b b b b]]} to be true'" do
      expect(subject.four_connected?(array18)).to be true
    end
    it "#{array19 = [*%w[b b b b], nil, *%w[a a a]]} to be true" do
      expect(subject.four_connected?(array19)).to be true
    end
    it "#{array20 = [nil, 'b', nil, *%w[b b b b]]} to be true" do
      expect(subject.four_connected?(array20)).to be true
    end
    it "#{array21 = %w[a a b b b b a]} to be true" do
      expect(subject.four_connected?(array21)).to be true
    end
    it "#{array22 = [nil, nil, nil, nil, *%w[b b b b]]} to be true" do
      expect(subject.four_connected?(array22)).to be true
    end
    it "#{array23 = [nil, nil, nil, nil, *%w[b b b]]} to be false" do
      expect(subject.four_connected?(array23)).not_to be true
    end
    it "#{array24 = [%w[a b a b a b a b]]} to be false" do
      expect(subject.four_connected?(array24)).not_to be true
    end
    it "#{array25 = [%w[b a b a b a b a]]} to be false" do
      expect(subject.four_connected?(array25)).not_to be true
    end
    it "#{array26 = ['a', 'b', 'b', nil, 'b', 'a', nil, 'b']} to be false" do
      expect(subject.four_connected?(array26)).not_to be true
    end
  end

  describe 'creation and testing of and across all necessary arrays' do
    test_ary = [[0, 7, 14, 21, 28, 35],
                [1, 8, 15, 22, 29, 36],
                [2, 9, 16, 23, 30, 37],
                [3, 10, 17, 24, 31, 38],
                [4, 11, 18, 25, 32, 39],
                [5, 12, 19, 26, 33, 40],
                [6, 13, 20, 27, 34, 41]]
    before(:each) { subject.verticals = test_ary }
    it 'sums up to 25 uniq arrays with verticals = test array' do
      expect(subject.all_arrays.uniq.size).to eql(25)
    end
    it 'with verticals = test array it returns victory = false' do
      expect(subject.victory?).to be false
    end
  end
end
