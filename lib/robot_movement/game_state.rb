module RobotMovement
  class GameState
    attr_accessor :x, :y, :direction, :active

    def initialize(x, y, direction, active = true)
      @x = x
      @y = y
      @direction = direction
      @active = active
    end

    def active?
      @active
    end

    def self.create_inactive
      new(nil, nil, nil, false)
    end
  end
end
