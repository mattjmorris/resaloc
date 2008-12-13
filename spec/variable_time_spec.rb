
require File.dirname(__FILE__) + '/../lib/Schedules/variable_time'

class Array
  def sum; inject( 0 ) { |sum,x| sum+x }; end
  def mean; sum.to_f / size; end
end

describe VariableTime do
  
  it "should have an average time and hold time" do
    average_time = 10
    hold_time = 1
    vt = VariableTime.new(average_time, hold_time)
    vt.average_time.should == 10
    vt.hold_time.should == 1
  end

  it "should, on average, signal after the average time has passed" do

    [1,2,5,10].each do |avg_time_to_signal|
    
      vt = VariableTime.new(avg_time_to_signal, 0)
      times_to_signal = []

      time_since_last_on = 0

      10000.times do
        vt.tick
        if vt.signal == VariableTime::SIGNAL_ON
          times_to_signal << time_since_last_on
          time_since_last_on = 0
        else
          time_since_last_on += 1
        end
      end

      times_to_signal.mean.should be_close(avg_time_to_signal - 1, 0.7)

    end

  end

end

