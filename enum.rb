module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0
    range = is_a?(Range) ? self.to_a : self
    par = is_a?(Range) ? size : length

    while i < par
      if is_a?(Range)
        yield(range[i])
      elsif is_a?(Hash)
        yield(keys[i], self[keys[i]])
      else
        yield(self[i])
      end
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    my_each do
      yield(i, self[i])
      i += 1
    end
  end

  def my_select
    return to_enum unless block_given?

    arr = []
    my_each { |i| arr << i if yield(i) }
    arr
  end

  def my_all?
    return to_enum unless block_given?

    b = true
    self.my_each do |i|
      b = yield(i)
      break unless !b
    end
    b
  end

  def my_any?
    return to_enum unless block_given?

    b = true
    my_each do |i|
      b = yield(i)
      break if b
    end
    b
  end

  def my_none?
    return to_enum unless block_given?

    b = true
    self.my_each do |i|
      b = !yield(i)
      break if b
    end
    b
  end

  def my_count
    i = 0
    my_each do |i|
      i += 1
    end
    i
  end

  def my_map(proc = nil)
    return to_enum unless block_given? or proc

    arr = []
    my_each do |i|
      if block_given?
        arr << yield(i)
      else
        arr << proc.call(i)
      end
    end
    arr
  end

  def my_inject
    # return to_enum unless block_given?
    x = self[0]
    self[1..self.length].my_each do |i|
      x = yield(x, i)
    end
    x
  end
end
