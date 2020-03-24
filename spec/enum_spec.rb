require_relative '../enum.rb'

RSpec.describe Enumerable do
  let(:numbers) { (-10..10).to_a }
  let(:numbers_idx) { (-10..10).to_a.map.with_index { |a, i| [a, i] } }
  let(:hash) { { a: :b, c: :d } }
  let(:hash_idx) { { a: :b, c: :d }.to_a.map.with_index { |k, v| [k, v] } }
  let(:array_of_tuples) { [%i[a b], %i[c d]] }
  let(:array_of_tuples_idx) { [%i[a b], %i[c d]].map.with_index { |k, v| [k, v] } }

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
    it { expect { |b| hash.my_select(&b) }.to yield_successive_args(*hash.to_a) }
  end

#   describe '#' do
      
#   end

#   describe '#' do
      
#   end

#   describe '#' do
      
#   end

#   describe '#' do
      
#   end

#   describe '#' do
      
#   end

#   describe '#' do
      
#   end
end