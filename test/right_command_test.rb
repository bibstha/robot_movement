require "minitest/autorun"
require "mocha/mini_test"

require_relative "../right_command"
require_relative "../game_state"

class RightCommandTest < Minitest::Unit::TestCase
  attr_reader :state, :command

  def setup
    @state = GameState.new(1, 1, "north")
    @command = RightCommand.new
  end

  def test_run
    command.expects(:turn).with(state, :right)
    command.run(state)
  end
end
