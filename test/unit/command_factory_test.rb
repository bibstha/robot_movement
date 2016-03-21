require_relative "../test_helper"

require "robot_movement/command_factory"

require "robot_movement/place_command"
require "robot_movement/left_command"
require "robot_movement/right_command"
require "robot_movement/move_command"
require "robot_movement/report_command"

class CommandFactoryTest < Minitest::Test
  include RobotMovement

  def test_create_from_returns_right_command
    factory = CommandFactory

    command = factory.create_from("LEFT")
    assert(command.is_a?(LeftCommand))

    command = factory.create_from("RIGHT")
    assert(command.is_a?(RightCommand))

    command = factory.create_from("MOVE")
    assert(command.is_a?(MoveCommand))

    command = factory.create_from("PLACE 1,2,WEST")
    assert(command.is_a?(PlaceCommand))
    assert_equal(1, command.x)
    assert_equal(2, command.y)
    assert_equal("west", command.direction)

    command = factory.create_from("report")
    assert(command.is_a?(ReportCommand))
  end
end
