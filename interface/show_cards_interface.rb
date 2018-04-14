# frozen_string_literal: true

module Interface
  class ShowCardsInterface < BasicTableInterface
    def perform
      calculate_winner
      super
    end

    private

    def interface_title
      puts "\n"
      "\tActions:"
    end

    def commands
      {
        1 => { text: 'Play again', action: :play_again },
        2 => { text: 'Exit', action: :exit }
      }
    end

    def play_again
      table_manager.prepare_new_game
      give_out_cards_interface.perform
    end

    def calculate_winner
      if table_manager.draw?
        handle_draw
      else
        winner = table_manager.find_winner
        handle_win(winner)
      end
    end

    def handle_win(player)
      print_win_message(player)
      player.money += bank
      main.bank = 0
    end

    def handle_draw
      prize = bank / 2
      print_draw_message
      user.money += prize
      dealer.money += prize
      main.bank = 0
    end

    def print_dealer_ui
      print "\tDealer cards: "
      print_cards(dealer)
      super
      print_cards_value(dealer)
    end

    def print_cards_value(player)
      name = player.instance_of?(User) ? 'Your' : player.name
      puts "\t#{name} score: #{player.best_value}"
    end

    def print_win_message(player)
      message = "\t" * 3 + "#{player.name.upcase} WON #{bank}"
      line_lg_wrap(message)
    end

    def print_draw_message
      message = "\t" * 3 + 'DRAW!'
      line_lg_wrap(message)
    end

    def give_out_cards_interface
      GiveOutCardsInterface.new(main)
    end
  end
end
