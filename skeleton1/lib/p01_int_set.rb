require "byebug"
class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max) {false}
  end

  def insert(num)
    if is_valid?(num)
      @store[num] = true
    else
      raise "Out of bounds"
    end
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num <= (@max - 1) && num >= 0 
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[(num % num_buckets)] << num
  end

  def remove(num)
    # raise "Out of bounds" unless is_valid?
    
    @store[num % num_buckets].delete(num)
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end
  
  def insert(num)
    
    unless @store[(num % num_buckets)].include?(num) 
      @store[(num % num_buckets)] << num 
      @count += 1
      resize! if @count == num_buckets  
    else 
      return
    end 
  end 
  
  def remove(num)
    unless @store[(num % num_buckets)].include?(num)
      return
    else
      # debugger
      @store[(num % num_buckets)].delete(num)   
      @count -= 1
    end
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    row, col = num
    self[row][col]
  end

  def num_buckets
    @store.length
  end

  def resize!
    prev_num_buckets = @num_buckets
    resized = Array.new(prev_num_buckets * 2) { Array.new }
    @store.flatten.each do |num|
      resized[num % resized.length] << num
    end
    @store = resized
  end
end
