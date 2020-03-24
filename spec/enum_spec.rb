require_relative '../enum.rb'

RSpec.describe Enumerable do
  let(:numbers) { (-10..10).to_a }
  let(:numbers_idx) { (-10..10).to_a.map.with_index { |a, i| [a, i] } }
  let(:hash) { { a: :b, c: :d } }
  let(:hash_idx) { { a: :b, c: :d }.to_a.map.with_index { |k, v| [k, v] } }
  let(:array_of_tuples) { [%i[a b], %i[c d]] }
  let(:array_of_tuples_idx) { [%i[a b], %i[c d]].map.with_index { |k, v| [k, v] } }
  let(:mixed_values) { [true, false, nil, 1, 'a'] }
  let(:falsies) { [false, false, false] }

  describe '#my_each' do
    it 'returns an enumerable object when no block is given' do
      expect(numbers.my_each).to be_kind_of(Enumerator)
    end

    it 'returns the collection that called the method when a block is given' do
      expect(numbers.my_each {}).to eq(numbers)
    end

    it 'returns the hash that called the method when a block is given' do
      expect(hash.my_each {}).to eq(hash)
    end

    it { expect { |b| numbers.my_each(&b) }.to yield_successive_args(*numbers) }
    it { expect { |b| array_of_tuples.my_each(&b) }.to yield_successive_args(*array_of_tuples) }
    it { expect { |b| hash.my_each(&b) }.to yield_successive_args(*hash.to_a) }
  end

  describe '#my_each_with_index' do
    it 'returns an enumerable object when no block is given' do
      expect(numbers.my_each_with_index).to be_kind_of(Enumerator)
    end

    it 'returns the collection that called the method when a block is given' do
      expect(numbers.my_each_with_index {}).to eq(numbers)
    end

    it 'returns the hash that called the method when a block is given' do
      expect(hash.my_each_with_index {}).to eq(hash)
    end

    it { expect { |b| numbers.my_each_with_index(&b) }.to yield_successive_args(*numbers_idx) }
    it { expect { |b| array_of_tuples.my_each_with_index(&b) }.to yield_successive_args(*array_of_tuples_idx) }
    it { expect { |b| hash.my_each_with_index(&b) }.to yield_successive_args(*hash_idx) }
  end

  describe '#my_select' do
    it 'returns an enumerable object when no block is given' do
      expect(numbers.my_select).to be_kind_of(Enumerator)
    end

    it 'returns an array with all the elements matching the argument given' do
      expect(numbers.my_select {|item| item == 1 }).to eq([1])
    end

    it { expect { |b| numbers.my_select(&b) }.to yield_successive_args(*numbers) }
    it { expect { |b| array_of_tuples.my_select(&b) }.to yield_successive_args(*array_of_tuples) }
    it { expect { |b| hash.select(&b) }.to yield_successive_args(*hash.to_a) }
  end

  describe '#my_all?' do
    it 'returns true when no element is false or nill and no block is given' do
      expect(numbers.my_all?).to be true
    end

    it 'returns true when all the elements of the array passes the block condition' do
      expect(numbers.my_all?{ |number| number > -11}).to be true
    end

    it 'returns false when at least one element is false or nill' do
      expect(mixed_values.my_all?).to be false
    end

    it 'returns false when at least one element of the array doesnt pass the block' do
      expect(numbers.my_all? { |number| number < 10}).to be false
    end

    it 'returns true for an empty collection' do
      expect([].my_all?).to be true
    end

    it 'returns true for an empty hash' do
      expect({}.my_all?).to be true
    end

    it 'returns true if all the elements has case equality with argument given' do
      expect(numbers.my_all?(Numeric)).to be true
    end
  end

  describe '#my_any?' do
    it 'returns true when at least one element in the collection is truthy' do
      expect(mixed_values.my_any?).to be true
    end

    it 'returns false when none of the elements in the collection is truthy' do
      expect(falsies.my_any?).to be false
    end

    it 'returns true one at least one element in the collection passes the block condition' do
      expect(numbers.my_any? { |item| item > 9 }).to be true
    end

    it 'returns false when the caller collection is empty' do
      expect([].my_any?).to be false
    end

    it 'returns true when any of the elements in the collection has case equality with the argument given' do
      expect(mixed_values.my_any?(/a/)).to be true
    end
  end

#   describe '#' do
      
#   end

#   describe '#' do
      
#   end

#   describe '#' do
      
#   end

#   describe '#' do
      
#   end
end