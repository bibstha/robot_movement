require_relative "../test_helper"

require "minitest/autorun"
require "robot_movement/game_state"

class GameStateTest < Minitest::Unit::TestCase
  include RobotMovement

  def test_active?
    state = GameState.new(1, 1, "west", true)
    assert(state.active?)

    state = GameState.new(1, 1, "west")
    assert(state.active?)

    state = GameState.new(1, 1, "west", false)
    refute(state.active?)

    state = GameState.create_inactive
    refute(state.active?)
  end
end
