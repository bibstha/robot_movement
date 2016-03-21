require_relative "errors"

module RobotMovement
  class MoveCommand
    def run(state)
      raise InvalidGameState unless state.active?

      case state.direction
      when "north"
        state.y += 1 if state.y < 4
      when "east"
        state.x += 1 if state.x < 4
      when "south"
        state.y -= 1 if state.y > 0
      when "west"
        state.x -= 1 if state.x > 0
      end
    end
  end
end
