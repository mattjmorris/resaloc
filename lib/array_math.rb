# To change this template, choose Tools | Templates
# and open the template in the editor.

module ArrayMath

  class Array

    def mean; sum.to_f / size; end

    def sum
     inject( 0 ) { |sum,x| sum+x }
    end

  end
  
end
