module RobotMovement
  class PlaceCommand
    attr_reader :x, :y, :direction

    def initialize(x, y, direction)
      @x = x.to_i
      @y = y.to_i
      @direction = direction

      validate
    end

    def run(state)
      state.x = x
      state.y = y
      state.direction = direction
      state.active = true
    end

    private

    ValidDirections = %w(north east south west)

    def validate
      raise ArgumentError, "x should be within 0..4" unless (0..4).include?(x)
      raise ArgumentError, "y should be within 0..4" unless (0..4).include?(y)
      raise ArgumentError, "direction should be one of east|west|north|south" unless ValidDirections.include?(direction)
    end
  end
end
