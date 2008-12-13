
require 'ticker'
require 'scheduler'
require 'agent'

class Simulation
  
  def initialize
    scheduler = Scheduler.new
    @agent = Agent.new([scheduler])
    @agent.register_listener(self)
    @ticker = Ticker.new(100)
    @ticker.register_tick_receiver(scheduler)
    @ticker.register_tick_receiver(@agent)
    @ticker.register_result_listener(self)
  end
  
  def run
    @ticker.run
    p @agent.current_value
  end
  
  def notify(event)
    p event
  end
  
end

simulator = Simulator.new
simulator.run
