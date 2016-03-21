require_relative "game_state"
require_relative "command_factory"

module RobotMovement
  class Cli
    def run
      verify_arguments
      execute_file
    end

    def verify_arguments
      unless filename
        puts "Invalid Syntax"
        puts "Usage: {$PROGRAM_NAME} input_file"
        exit(1)
      end

      unless File.exist?(filename)
        puts "File #{filename} does not exist"
        puts "Usage: {$PROGRAM_NAME} input_file"
        exit(1)
      end
    end

    def execute_file
      lines = File.readlines(filename).map!(&:chomp)
      execute_lines(lines)
    end

    def execute_lines(lines)
      state = GameState.create_inactive
      lines.each do |line|
        begin
          command = parse(line)
          command.run(state)
        rescue InvalidGameState
          # do nothing
        end
      end
    end

    def parse(line)
      CommandFactory.create_from(line)
    end

    def filename
      ARGV[0]
    end
  end
end
