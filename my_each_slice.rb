module Enumerable
  def my_each_slice(n)
    if n.is_a? String
      raise TypeError.new('no implicit conversion of String into Integer')
    elsif n < 1
      raise ArgumentError.new('invalid slice size')
    end

    if block_given?
      collection =
        if [Range, Hash].any? { |c| self.class == c }
          self.to_a
        else
          self
        end

      collection.each_with_index.inject([]) do |slice, (item, idx)|
        slice << item

        if slice.size == n || idx == collection.size - 1
          yield(slice)
          slice = []
        else
          slice
        end
      end

      nil
    else
      self.to_enum(:my_each_slice, n)
    end
  end
end


p (1..11).my_each_slice(3) { |slice| p slice }
p (1..11).my_each_slice(3)

p [1, 2, 'a', 4, 'b', 6, 7, 8, 'c', 'y', 'z'].my_each_slice(3) { |slice| p slice }
p [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11].my_each_slice(3)

p ({a: 1, b: 2, c: 3, d: 4, e: 5}.my_each_slice(2) { |slice| p slice })
p ({a: 1, b: 2, c: 3, d: 4, e: 5}.my_each_slice(2))

p ['a', 2].my_each_slice(3) { |slice| p slice }
p [1, 2].my_each_slice(3)

p [].my_each_slice(3) { |slice| p slice }
p [].my_each_slice(3)

# errors

# p [1, 2].each_slice(0) { |slice| p slice }
# p [1, 2].my_each_slice(0) { |slice| p slice }
#
# p [1, 2].each_slice(0.1) { |slice| p slice }
# p [1, 2].my_each_slice(0.1) { |slice| p slice }
#
# p [1, 2].each_slice('a') { |slice| p slice }
# p [1, 2].my_each_slice('1') { |slice| p slice }
