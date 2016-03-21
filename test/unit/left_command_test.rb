require_relative "../test_helper"

require "mocha/mini_test"

require "robot_movement/left_command"
require "robot_movement/game_state"

class LeftCommandTest < Minitest::Test
  include RobotMovement

  attr_reader :state, :command

  def setup
    @state = GameState.new(1, 1, "north")
    @command = LeftCommand.new
  end

  def test_run
    command.expects(:turn).with(state, :left)
    command.run(state)
  end

  def test_with_inactive_state
    inactive_state = GameState.create_inactive
    assert_raises (InvalidGameState) { command.run(inactive_state) }
  end
end
