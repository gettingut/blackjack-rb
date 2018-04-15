# frozen_string_literal: true

module Interface
  class NewPlayerInterface < BasicInterface
    def perform
      puts interface_title
      create_player
      create_dealer
      give_out_cards
    rescue ArgumentError => e
      puts e.message + "\n\n"
      retry
    end

    private

    def give_out_cards
      give_out_cards_interface.perform
    end

    def interface_title
      "\tInput your name:"
    end

    def create_player
      name = gets.chomp
      main.players << new_user(name)
    end

    def create_dealer
      main.players << new_dealer
    end

    def give_out_cards_interface
      GiveOutCardsInterface.new(main)
    end

    def new_user(name)
      User.new(name)
    end

    def new_dealer
      Dealer.new
    end
  end
end
