
class AgentBak
  
  def initialize(resources, name = "Agent Smith")
    @name = name
    @resources = resources
    # for now just grabbing first to start, but probably should be random
    @current_resource = @resources.first
    @current_resource.register_agent(self)
    @current_earnings = 0
    @listeners = []
  end
  
  def tick
    
    if resource_change
      @current_resource.unregister_agent(self)
      @current_resource = get_resource_to_use
      @current_resource.register_agent(self)
    end
    
    notify_listeners("#{@name}'s current value is #{@current_earnings}")
    
  end
  
  def resource_delivery(amount)
    @current_earnings += amount
  end
  
  def register_listener(listener)
    @listeners << listener
  end
  
  private
  
  def resource_change
    return false
  end
  
  # For now, just the first one, but need to make a strategy
  def get_resource_to_use
    return @resources.first
  end
  
  def notify_listeners(msg)
    @listeners.each {|listener| listener.notify(msg)}
  end
  
end
