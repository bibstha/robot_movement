require_relative "errors"

module RobotMovement
  class ReportCommand
    attr_reader :reporter

    def initialize(reporter = PutsReporter)
      @reporter = reporter
    end

    def run(state)
      raise InvalidGameState unless state.active?

      reporter.new.report "#{state.x},#{state.y},#{state.direction.upcase}"
    end

    class PutsReporter
      def report(string)
        puts string
      end
    end
  end
end
