module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0
    range = is_a?(Range) ? to_a : self
    par = is_a?(Range) ? size : length
    while i < par
      if is_a?(Hash)
        yield(keys[i], self[keys[i]])
      else
        yield(range[i])
      end
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    my_each do
      if is_a?(Hash)
        yield(self[keys[i]], keys[i])
      else
        yield(self[i], i)
      end
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
    my_each do |i|
      if !arg[0].nil?
        return false unless arg[0].equal? i
      elsif block_given?
        return false unless yield(i)
      else
        return false unless i
      end
    end
    true
  end

  def my_any?(*arg)
    my_each do |i|
      if !arg[0].nil?
        return true if arg[0].equal? i
      elsif block_given?
        return true if yield(i)
      elsif i
        return true
      end
    end
    false
  end

  def my_none?(arg = nil, &block)
    !my_any?(arg, &block)
  end

  def my_count(arg = nil)
    count = 0
    my_each do |i|
      if !arg.nil?
        count += 1 if i == arg
      elsif block_given?
        count += 1 if yield(i)
      else
        count += 1
      end
    end
    count
  end

  def my_map(proc = nil)
    return to_enum unless block_given? or proc

    arr = []
    my_each do |i|
      arr << block_given? ? yield(i) : proc.call(i)
    end
    arr
  end

  # rubocop:todo Metrics/PerceivedComplexity
  def my_inject(par1 = nil, par2 = nil) # rubocop:todo Metrics/CyclomaticComplexity
    arr = is_a?(Array) ? self : to_a

    x = par1 if par1.is_a?(Integer)

    y = par1 if par1.is_a?(Symbol) || par1.is_a?(String)

    if par1.is_a?(Integer)
      y = par2 if par2.is_a?(Symbol) || par2.is_a?(Integer)
    end

    arr.my_each do |i|
      if block_given?
        x = x ? yield(x, i) : i
      elsif y
        x = x ? x.send(y, i) : i
      end
    end
    x
  end
  # rubocop:enable Metrics/PerceivedComplexity
end

def multiply_els(arg)
  arg.my_inject { |m, n| m * n }
end
multiply_els([2, 4, 5])
