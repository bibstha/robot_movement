require_relative "../test_helper"

require "minitest/autorun"
require "mocha/mini_test"
require "robot_movement/cli"

class ExamplesTest < Minitest::Unit::TestCase
  include RobotMovement

  attr_reader :cli

  def setup
    @cli = Cli.new
  end

  def expect_output(str)
    klass = RobotMovement::ReportCommand::PutsReporter
    klass.any_instance.expects(:report).with(str)
  end

  def test_example_1
    expect_output("0,1,NORTH")

    commands = [
      "PLACE 0,0,NORTH",
      "MOVE",
      "REPORT"
    ]
    cli.execute_lines(commands)
  end

  def test_example_2
    expect_output("0,0,WEST")

    commands = [
      "PLACE 0,0,NORTH",
      "LEFT",
      "REPORT"
    ]
    cli.execute_lines(commands)
  end

  def test_example_3
    expect_output("3,3,NORTH")

    commands = [
      "PLACE 1,2,EAST",
      "MOVE",
      "MOVE",
      "LEFT",
      "MOVE",
      "REPORT"
    ]
    cli.execute_lines(commands)
  end
end
