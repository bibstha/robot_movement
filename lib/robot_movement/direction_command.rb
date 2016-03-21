module RobotMovement
  class DirectionCommand
    Directions = ["north", "east", "south", "west"]

    def turn(state, direction)
      current_direction = Directions.index(state.direction)

      new_direction =
        case direction
        when :left
          current_direction - 1
        when :right
          current_direction + 1
        else
          raise ArgumentError, "wrong value for direction, should be :left or :right"
        end

      state.direction = Directions[new_direction % 4]
    end
  end
end
