require_relative "direction_command"

class RightCommand < DirectionCommand
  def run(state)
    turn(state, :right)
  end
end
