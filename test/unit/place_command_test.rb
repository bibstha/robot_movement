require_relative "../test_helper"

require "minitest/autorun"

require "robot_movement/place_command"
require "robot_movement/game_state"

class PlaceCommandTest < Minitest::Unit::TestCase
  include RobotMovement

  def test_initialize_valid_game_state
    PlaceCommand.new(1, 2, "west")
  end

  def test_initialize_invalid_game_state
    assert_raises (ArgumentError) { PlaceCommand.new(-1, 2, "west") }
    assert_raises (ArgumentError) { PlaceCommand.new(5, 2, "east") }
    assert_raises (ArgumentError) { PlaceCommand.new(1, -2, "north") }
    assert_raises (ArgumentError) { PlaceCommand.new(1, 5, "south") }
    assert_raises (ArgumentError) { PlaceCommand.new(1, 4, "wrong") }
  end

  def test_change_of_game_state
    state = GameState.create_inactive
    command = PlaceCommand.new(1, 2, "north")
    command.run(state)

    assert_equal(1, state.x)
    assert_equal(2, state.y)
    assert_equal("north", state.direction)
  end

  def test_change_of_game_state_2
    state = GameState.create_inactive
    state.x = 4; state.y = 1; state.direction = "east"

    command = PlaceCommand.new(4, 0, "north")
    command.run(state)

    assert_equal(4, state.x)
    assert_equal(0, state.y)
    assert_equal("north", state.direction)
  end
end
