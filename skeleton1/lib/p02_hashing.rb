class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = 0
    self.each_with_index do |el, idx|
      result += (el.hash ^ idx) 
    end
    result
  end
end

class String
  def hash
    alpha = ("a".."z").to_a
    num = (0..9).to_a
    alpha.concat(num)
    self.chars.map { |char| alpha.index(char) }.join.to_i.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
    self.length.hash
  end
end
