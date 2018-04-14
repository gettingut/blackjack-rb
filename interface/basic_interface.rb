# frozen_string_literal: true

module Interface
  class BasicInterface
    def initialize(main)
      @main = main
    end

    def perform
      print_commands
      @input = input_command
      return unless input
      command_to_action(input)
    end

    protected

    attr_reader :main, :input

    UNKNOWN_COMMAND = "Unknown command.\n\n"

    def print_commands
      puts interface_title
      commands.each { |num, command| puts "\t#{num}: #{command[:text]}" }
    end

    def input_command
      command = gets.chomp.to_i
      if valid_command?(command)
        command
      else
        puts UNKNOWN_COMMAND
        input_command
      end
    end

    def command_to_action(command)
      send(commands[command][:action])
    end

    def valid_command?(command)
      commands.keys.include?(command)
    end

    def players
      main.players
    end

    def user
      main.user
    end

    def dealer
      main.dealer
    end

    def bank
      main.bank
    end
  end
end
