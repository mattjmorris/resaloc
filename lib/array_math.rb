# To change this template, choose Tools | Templates
# and open the template in the editor.

class Array

  def mean; sum.to_f / size; end

  def sum
   inject( 0 ) { |sum,x| sum+x }
  end

  def perm(n = size)
    if size < n or n < 0
    elsif n == 0
      yield([])
    else
      self[1..-1].perm(n - 1) do |x|
        (0...n).each do |i|
          yield(x[0...i] + [first] + x[i..-1])
        end
      end
      self[1..-1].perm(n) do |x|
        yield(x)
      end
    end
  end

end
