require_relative "../test_helper"

require "minitest/autorun"

require "robot_movement/cli"
require "robot_movement/place_command"
require "robot_movement/left_command"
require "robot_movement/right_command"
require "robot_movement/move_command"
require "robot_movement/report_command"
require "robot_movement/errors"

class CliTest < Minitest::Unit::TestCase
  include RobotMovement

  attr_reader :cli

  def setup
    @cli = Cli.new
  end

  def test_parse_valid_commands
    command = cli.parse("LEFT")
    assert(command.is_a?(LeftCommand))

    command = cli.parse("RIGHT")
    assert(command.is_a?(RightCommand))

    command = cli.parse("MOVE")
    assert(command.is_a?(MoveCommand))

    command = cli.parse("PLACE 1,2,WEST")
    assert(command.is_a?(PlaceCommand))
    assert_equal(1, command.x)
    assert_equal(2, command.y)
    assert_equal("west", command.direction)

    command = cli.parse("report")
    assert(command.is_a?(ReportCommand))
  end

  def test_parse_invalid
    assert_raises (InvalidCommand) { cli.parse("INVALIDCOMMAND") }
  end
end
