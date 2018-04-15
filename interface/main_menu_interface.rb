# frozen_string_literal: true

module Interface
  class MainMenuInterface < BasicInterface
    include UserActions

    def perform
      print_logo
      super
    end

    private

    def actions
      {
        1 => { text: 'Play', method: :play },
        2 => { text: 'Exit', method: :exit }
      }
    end

    def actions_title
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
