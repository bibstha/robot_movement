require_relative "direction_command"

class LeftCommand < DirectionCommand
  def run(state)
    turn(state, :left)
  end
end
