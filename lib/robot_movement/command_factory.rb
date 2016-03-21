require_relative "place_command"
require_relative "left_command"
require_relative "right_command"
require_relative "move_command"
require_relative "report_command"

module RobotMovement
  class CommandFactory
    def self.create_from(command_string)
      command_name, args = command_string.downcase.split(" ")

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
