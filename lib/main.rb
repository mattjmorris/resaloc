require 'action'
require 'state'
require 'agent'

state_a = State.new("a", 0)

move_to_b = Action.new("move_to_b", -1, State.new("b", 10))

move_to_c = Action.new("move_to_c", -1, State.new("c", 0))

state_a.actions = [move_to_b, move_to_c]

smith = Agent.new("Smith", state_a)

actions_selected = []

100.times do

  smith.tick

  actions_selected << smith.action

  # put smith back to beginning
  smith.state = state_a

end

#p actions_selected.collect{|action| action.name}
count = 0
actions_selected.each{|action| count += 1 if action.name == move_to_b.name}
p count
p smith.bank
