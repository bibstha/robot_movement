require_relative "../test_helper"

require "minitest/autorun"
require "mocha/mini_test"

require "robot_movement/right_command"
require "robot_movement/game_state"
require "robot_movement/errors"

class RightCommandTest < Minitest::Test
  include RobotMovement

  attr_reader :state, :command

  def setup
    @state = GameState.new(1, 1, "north")
    @command = RightCommand.new
  end

  def test_run
    command.expects(:turn).with(state, :right)
    command.run(state)
  end

  def test_with_inactive_state
    inactive_state = GameState.create_inactive
    assert_raises (InvalidGameState) { command.run(inactive_state) }
  end
end
