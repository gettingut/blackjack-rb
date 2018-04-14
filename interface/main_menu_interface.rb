# frozen_string_literal: true

module Interface
  class MainMenuInterface < BasicInterface
    def perform
      print_logo
      super
    end

    private

    def commands
      {
        1 => { text: 'Play', action: :play },
        2 => { text: 'Exit', action: :exit }
      }
    end

    def interface_title
      "\n\t\tMain menu\n"
    end

    def play
      new_player_interface.perform
    end

    def exit
      Kernel.exit
    end

    def new_player_interface
      NewPlayerInterface.new(main)
    end

    def print_logo
      logo = File.open('interface/logo.txt')
      logo.each_line { |line| print "\t #{line}" }
    end
  end
end
