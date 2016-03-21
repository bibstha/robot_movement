require_relative "../test_helper"

require "robot_movement/report_command"
require "robot_movement/game_state"

class ReportCommandTest < Minitest::Test
  include RobotMovement

  def test_reports
    reporter = Minitest::Mock.new
    reporter.expect(:report, nil, ["2,4,NORTH"])

    state = GameState.new(2, 4, "north")

    command = ReportCommand.new(reporter)
    command.run(state)
  end
end
