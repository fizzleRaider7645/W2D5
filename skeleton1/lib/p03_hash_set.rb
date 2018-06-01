class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(key)
    hashed_key = key.hash
    unless @store[(hashed_key % num_buckets)].include?(key) 
      @store[(hashed_key % num_buckets)] << key 
      @count += 1
      resize! if @count == num_buckets  
    else 
      return
    end 
  end

  def include?(key)
    hashed_key = key.hash
    @store[hashed_key % num_buckets].include?(key)
    
  end

  def remove(key)
    hashed_key = key.hash
    
    unless @store[(hashed_key % num_buckets)].include?(key)
      return
    else
      # debugger
      @store[(hashed_key % num_buckets)].delete(key)   
      @count -= 1
    end
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
      hashed_key = num.hash 
      resized[hashed_key % resized.length] << num
    end
    @store = resized
  end
end
