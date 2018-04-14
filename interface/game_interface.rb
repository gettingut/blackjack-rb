# frozen_string_literal: true

module Interface
  class GameInterface < BasicTableInterface
    private

    def commands
      {
        1 => { text: 'Check', action: :user_checks },
        2 => { text: 'Take card', action: :user_take_card },
        3 => { text: 'Show your cards', action: :user_show_cards }
      }
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

    def user_checks
      dealer_turn
      perform
    end

    def user_take_card
      table_manager.give_cards(user, 1)
      dealer_turn
      show_cards_interface.perform
    end

    def user_show_cards
      show_cards_interface.perform
    end

    def dealer_turn
      give_card(dealer) if dealer.take_card?
    end

    def give_card(dealer)
      table_manager.give_cards(dealer, 1)
      message = "\t\t  Dealer took a card!"
      line_lg_wrap(message)
    end

    def print_hidden_cards(player)
      player.cards.each { |_card| print '* ' }
    end

    def show_cards_interface
      ShowCardsInterface.new(main)
    end
  end
end
