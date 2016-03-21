require_relative "../test_helper"

require "mocha/mini_test"

require "robot_movement/cli"
require "robot_movement/left_command"
require "robot_movement/right_command"
require "robot_movement/errors"

class CliTest < Minitest::Test
  include RobotMovement

  attr_reader :cli

  def setup
    @cli = Cli.new
  end

  def test_parse_invalid
    assert_raises (InvalidCommand) { cli.parse("INVALIDCOMMAND") }
  end

  def test_execute_lines
    MoveCommand.any_instance.expects("run").once
    LeftCommand.any_instance.expects("run").once

    lines = %w(MOVE LEFT)
    cli.execute_lines(lines)
  end
end
