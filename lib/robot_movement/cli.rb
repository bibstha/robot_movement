require_relative "game_state"
require_relative "place_command"
require_relative "left_command"
require_relative "right_command"
require_relative "move_command"
require_relative "report_command"

module RobotMovement
  class Cli
    def run
      filename = ARGV[1]
      verify_arguments(filename)
      execute_file(filename)
    end

    def verify_arguments(fiename)
      unless filename
        puts "Syntax #{ARGV[0]} input_file"
        exit(1)
      end

      unless File.exist(filename)
        puts "File #{filename} does not exist"
        exit(1)
      end
    end

    def execute_file(filename)
      lines = File.readlines(filename)
      execute_lines(lines)
    end

    def execute_lines(lines)
      state = GameState.create_inactive
      lines.each do |line|
        command = parse(line.chomp)
        command.run(state)
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
  end
end
