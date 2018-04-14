# frozen_string_literal: true

module Interface
  class GiveOutCardsInterface < BasicTableInterface
    def perform
      table_manager.give_out_cards
      print_ui
      make_bets
      sleep(1)
      game_interface.perform
    end

    private

    def print_making_bets_message
      message = "\t\t" + ' ' * 5 + 'Making bets!'
      line_lg_wrap(message)
    end

    def make_bets
      print_making_bets_message
      main.players.each { |player| table_manager.take_bet(player, 10) }
    end

    def interface_title
      puts "\n"
      "\tActions:"
    end

    def print_dealer_ui
      print "\tDealer cards: "
      print_hidden_cards(dealer)
      super
    end

    def print_hidden_cards(player)
      player.cards.each { |_card| print '* ' }
    end

    def game_interface
      GameInterface.new(main)
    end
  end
end
