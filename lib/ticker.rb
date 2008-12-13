
class Ticker
  
  attr_accessor :max_ticks, :tick_count
  
  def initialize(max_ticks)
    @max_ticks = max_ticks
    @tick_count = 0
    @listeners = []
  end
  
  def register_listener(listener)
    @listeners << listener
  end
  
  def run
    
    while @tick_count < @max_ticks
      @tick_count += 1
      @listeners.each { |listener| listener.tick }
    end
    
  end
  
end
