require "minitest/autorun"

require_relative "../direction_command"
require_relative "../game_state"

class DirectionCommandTest < Minitest::Unit::TestCase
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
