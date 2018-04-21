# frozen_string_literal: true

class Interface
  LOGO_FILE_PATH = 'interface/logo.txt'
  LINE_LG = '*' * 55
  LINE_SM = '*' * 40

  def print_logo
    logo = File.open(LOGO_FILE_PATH)
    logo.each_line { |line| print "\t #{line}" }
  end

  def show_main_menu(actions)
    print_logo
    print_actions(actions, title: 'Menu')
  end

  def show_user_actions(actions)
    print_actions(actions, title: 'Actions')
  end

  def making_bets_message
    flash('Making bets!')
  end

  def draw_message
    flash('DRAW!')
  end

  def win_message(player, money)
    flash("#{player.name.upcase} WON #{money}")
  end

  def took_card_message(player)
    flash("#{player.name} took a card!")
  end

  def enter_name_message
    puts "\tInput your name:"
  end

  def show_game_table(players, bank, dealer_hidden: false)
    print_player_ui(players.last, info_hidden: dealer_hidden)
    puts "\t" * 3 + "Bank: #{bank}"
    print_player_ui(players.first)
  end

  def print_player_ui(player, info_hidden: false)
    print "\t#{player.name} cards: "
    print_cards(player, hidden: info_hidden)
    puts "\t#{player.name} money: #{player.money}"
    print_cards_value(player) unless info_hidden
  end

  def receive_action
    gets.to_i
  end

  def receive_name
    gets.chomp
  end

  private

  def print_actions(actions_hash, title: nil)
    puts "\t" + title if title
    actions_hash.each do |num, action_info|
      text = "\t#{num}: #{action_info[:text]} \n"
      print text
    end
  end

  def flash(message)
    puts LINE_LG
    puts "\t" * 3 + message
    puts LINE_LG
  end

  def print_cards(player, hidden: false)
    if hidden
      player.cards.each { |_card| print '* ' }
    else
      player.cards.each { |card| print "#{card.name}#{card.image} " }
    end
  end

  def print_cards_value(player)
    value = player.cards_value
    value = "#{value}(#{player.alt_cards_value})" if player.aces?
    puts "\tCARDS VALUE: #{value}"
  end
end
