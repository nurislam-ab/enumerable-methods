module Enumerable
  def my_each
    return to_enum unless block_given?

    for i in self do
      yield i
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    for x in self do
      yield(x, i)
      i += 1
    end
  end

  def my_select
    return to_enum unless block_given?

    arr = []
    self.my_each { |i| arr << i if yield(i) }
    arr
  end

  def my_all?
    return to_enum unless block_given?

    b = true
    self.my_each { |i|
      b = yield(i)
      break if !b
    }
    b
  end

  def my_any?
    return to_enum unless block_given?
    
    b = true
    self.my_each { |i|
      b = yield(i)
      break if b
    }
    b
  end

  def my_none?
    return to_enum unless block_given?

    b = true
    self.my_each { |i|
      b = !yield(i)
      break if b
    }
    b
  end

  def my_count
    i = 0
    for x in self do
      i += 1
    end
    i
  end

  def my_map(proc = nil)
    return to_enum unless block_given? or proc

    arr = []
    self.my_each { |i|
      if block_given?
        arr << yield(i)
      else
        arr << proc.call(i)
      end
    }
    arr
  end

  def my_inject
    # return to_enum unless block_given?
    x = self[0]
    for i in self[1..self.length] do
      x = yield(x, i)
    end
    x
  end
end
  