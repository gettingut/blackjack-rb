# frozen_string_literal: true

module Interface
  class BasicTableInterface < BasicInterface
    def perform
      print_ui
      super
    end

    private

    LINE_LG = '*' * 55
    LINE_SM = '*' * 40

    def print_ui
      print_dealer_ui
      print_bank_ui
      print_user_ui
    end

    def print_dealer_ui
      puts "\tDealer money: #{dealer.money}"
    end

    def print_user_ui
      username = user.name.capitalize
      print "\t#{username} cards: "
      print_cards(user)
      puts "\t#{username} money: #{user.money}"
      print_cards_value(user)
    end

    def print_bank_ui
      message = "\t" * 3 + "Bank: #{bank}"
      line_sm_wrap(message)
    end

    def print_cards_value(player)
      value = player.cards_value
      value = "#{value}(#{player.alt_cards_value})" if player.aces?
      puts "\tCARDS VALUE: #{value}"
    end

    def print_cards(player)
      player.cards.each { |card| print "#{card.name}#{card.suit.image} " }
    end

    def line_lg_wrap(message)
      puts LINE_LG
      puts message
      puts LINE_LG
    end

    def line_sm_wrap(message)
      puts "\t" + LINE_SM
      puts message
      puts "\t" + LINE_SM
    end

    def table_manager
      @table_manager ||= TableManager.new(main)
    end
  end
end
