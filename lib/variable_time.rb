require 'observer'

class VariableTime
  include Observable

  attr_accessor :average_time, :hold_time
  attr_reader :signal

  SIGNAL_OFF = "Off"
  SIGNAL_ON = "On"
  
  def initialize(average_time, hold_time)
    @average_time, @hold_time = average_time, hold_time
    @signal = SIGNAL_OFF
    @ticks_since_signal_on = 0
  end

  # Set signal to on only on average, every @average_time number of ticks
  def tick
    turn_signal_off_if_past_hold
    turn_signal_on_if_time unless @signal == SIGNAL_ON
  end

  def signal_on?
    return @signal == SIGNAL_ON
  end

  private

  def turn_signal_off_if_past_hold
    @signal == SIGNAL_ON ? @ticks_since_signal_on += 1 : @ticks_since_signal_on = 0
    @signal = SIGNAL_OFF if @ticks_since_signal_on > @hold_time
  end

  def turn_signal_on_if_time
    if random_event_hit 
      @signal = SIGNAL_ON
    else
      @signal = SIGNAL_OFF
    end
  end

  def random_event_hit
    1+rand(@average_time) == @average_time
  end

end
