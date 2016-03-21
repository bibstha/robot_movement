require_relative "../test_helper"

require "minitest/autorun"
require "robot_movement/direction_command"
require "robot_movement/game_state"

class DirectionCommandTest < Minitest::Test
  include RobotMovement

  attr_reader :state, :command

  def setup
    @state = GameState.new(1, 1, "north")
    @command = DirectionCommand.new
  end

  def test_execute_left
    command.turn(state, :left)
    assert_equal(state.direction, "west")

    command.turn(state, :left)
    assert_equal(state.direction, "south")

    command.turn(state, :left)
    assert_equal(state.direction, "east")

    command.turn(state, :left)
    assert_equal(state.direction, "north")
  end

  def test_execute_right
    command.turn(state, :right)
    assert_equal(state.direction, "east")

    command.turn(state, :right)
    assert_equal(state.direction, "south")

    command.turn(state, :right)
    assert_equal(state.direction, "west")

    command.turn(state, :right)
    assert_equal(state.direction, "north")
  end

  def test_invalid_direction
    assert_raises (ArgumentError) { command.turn(state, :invalid) }
  end
end
