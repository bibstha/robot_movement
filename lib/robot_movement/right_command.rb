require_relative "direction_command"

module RobotMovement
  class RightCommand < DirectionCommand
    def run(state)
      raise InvalidGameState unless state.active?

      turn(state, :right)
    end
  end
end
