require_relative "direction_command"
require_relative "errors"

module RobotMovement
  class LeftCommand < DirectionCommand
    def run(state)
      raise InvalidGameState unless state.active?

      turn(state, :left)
    end
  end
end
