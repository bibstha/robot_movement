require "minitest/autorun"
require "mocha/mini_test"

require_relative "../left_command"
require_relative "../game_state"

class LeftCommandTest < Minitest::Unit::TestCase
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
    command.expects(:turn).never
    command.run(inactive_state)
  end
end
