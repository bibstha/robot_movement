require "minitest/autorun"

require_relative "../place_command"
require_relative "../game_state"
require_relative "../command_executor"

class GameStateTest < Minitest::Unit::TestCase
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
