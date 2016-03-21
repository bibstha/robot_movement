require_relative "../test_helper"

require "mocha/mini_test"

require "robot_movement/move_command"
require "robot_movement/game_state"
require "robot_movement/errors"

module RobotMovement
  class MoveCommandTest < Minitest::Test
    attr_reader :command

    def setup
      @command = MoveCommand.new
    end

    def verify_movement_about_center(move_direction, x, y, direction)
      state = GameState.new(2, 2, "north")
      state.direction = move_direction
      command.run(state)

      assert_equal(x, state.x)
      assert_equal(y, state.y)
      assert_equal(direction, state.direction)
    end

    def test_valid_movements
      verify_movement_about_center("north", 2, 3, "north")
      verify_movement_about_center("east",  3, 2, "east")
      verify_movement_about_center("south", 2, 1, "south")
      verify_movement_about_center("west",  1, 2, "west")
    end

    def test_invalid_movements
      state = GameState.new(0, 0, "south")
      command.run(state)
      assert_equal(0, state.x)
      assert_equal(0, state.y)
      assert_equal("south", state.direction)

      state = GameState.new(0, 0, "west")
      command.run(state)
      assert_equal(0, state.x)
      assert_equal(0, state.y)
      assert_equal("west", state.direction)

      state = GameState.new(4, 4, "north")
      command.run(state)
      assert_equal(4, state.x)
      assert_equal(4, state.y)
      assert_equal("north", state.direction)

      state = GameState.new(4, 4, "east")
      command.run(state)
      assert_equal(4, state.x)
      assert_equal(4, state.y)
      assert_equal("east", state.direction)
    end

    def test_with_inactive_state
      inactive_state = GameState.create_inactive
      assert_raises (InvalidGameState) { command.run(inactive_state) }
    end
  end
end
