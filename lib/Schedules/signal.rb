# To change this template, choose Tools | Templates
# and open the template in the editor.

class TimeSignal
  attr_reader :state

  def initialize
    @state = "Off"
  end

  def on?
    @state == "On"
  end

  def off?
    @state == "Off"
  end

  def turn_on
    @state = "On"
  end
  
end

p Signal.new
