module Enumerable
  def my_each_slice(n)
    slice = []
    i = 0
    
    if block_given?
      collection =
        if [Range, Hash].any? { |c| self.class == c }
          self.to_a
        else
          self
        end
      
      while i < collection.size
        slice << collection[i]
       
        if slice.size == n || i == collection.size - 1
          yield(slice)
          slice = []
        end
        
        i += 1
      end
    else
      self.to_enum(:my_each_slice, 3)
    end
  end
end

(1..11).my_each_slice(3) { |slice| p slice }
p (1..11).my_each_slice(3)

[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11].my_each_slice(3) { |slice| p slice }
p [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11].my_each_slice(3)

{a: 1, b: 2, c: 3, d: 4, e: 5}.my_each_slice(2) { |slice| p slice }
p ({a: 1, b: 2, c: 3, d: 4, e: 5}.my_each_slice(2))

