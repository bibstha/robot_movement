require_relative "game_state"
require_relative "place_command"
require_relative "left_command"
require_relative "right_command"
require_relative "move_command"
require_relative "report_command"

module RobotMovement
  class Cli
    def run
      verify_arguments
      execute_file
    end

    def verify_arguments
      unless filename
        puts "Invalid Syntax"
        puts "Usage: #{$0} input_file"
        exit(1)
      end

      unless File.exist?(filename)
        puts "File #{filename} does not exist"
        puts "Usage: #{$0} input_file"
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
      command_name, args = line.downcase.split(" ")
      klass = RobotMovement.const_get("#{command_name.capitalize}Command")
      if klass == PlaceCommand
        klass.new(*args.split(","))
      else
        klass.new
      end
    rescue NameError
      raise InvalidCommand, "Command #{command_name} not found"
    end

    def filename
      ARGV[0]
    end
  end
end
