# frozen_string_literal: true

class TableController
  include Referee

  INGAME_ACTIONS = {
    1 => { text: 'Check', method: :user_checks },
    2 => { text: 'Take card', method: :user_take_card },
    3 => { text: 'Show your cards', method: :user_show_cards }
  }.freeze
  ENDGAME_ACTIONS = {
    1 => { text: 'Play again', method: :play_again },
    2 => { text: 'Exit', method: :exit }
  }.freeze

  attr_reader :players, :interface, :bank

  def initialize(players, interface)
    @players = players
    @deck = new_deck
    @bank = 0
    @interface = interface
  end

  def start_new_game!
    give_out_cards
    interface.game_table_ui(players, bank, dealer_info_hidden: true)
    make_bets
    table_interface
  end

  private

  def table_interface(dealer_info_hidden: true)
    interface.game_table_ui(
      players,
      bank,
      dealer_info_hidden: dealer_info_hidden
    )
    actions_interface(INGAME_ACTIONS, 'Actions')
  end

  def make_bets
    interface.flash('Making bets!')
    players.each { |player| take_bet(player, 10) }
    sleep(1)
  end

  def take_bet(player, money)
    player.make_bet(money)
    @bank += money
  end

  def give_out_cards
    players.each { |player| give_cards(player, 2) }
  end

  def give_cards(player, amount)
    cards = @deck.pick_cards(amount)
    player.cards += cards
    interface.flash("#{player.name} took a card!")
  end

  def user_checks
    dealer_turn
    table_interface
  end

  def user_take_card
    give_cards(user, 1)
    dealer_turn
    user_show_cards
  end

  def dealer_turn
    give_cards(dealer, 1) if dealer.take_card?
  end

  def user_show_cards
    interface.game_table_ui(players, bank, dealer_info_hidden: false)
    if draw?(players)
      handle_draw
    else
      winner = find_winner(players)
      handle_win(winner)
    end
    actions_interface(ENDGAME_ACTIONS, 'Actions')
  end

  def actions_interface(actions, title)
    interface.print_actions(actions, title: title)
    input = interface.receive_action
    input_to_method(actions, input)
  end

  def handle_draw
    prize = bank / 2
    interface.flash('DRAW!')
    user.money += prize
    dealer.money += prize
    @bank = 0
  end

  def handle_win(player)
    message = "#{player.name.upcase} WON #{bank}"
    interface.flash(message)
    player.money += bank
    @bank = 0
  end

  def play_again
    players.each { |player| player.cards = [] }
    @deck = new_deck
    start_new_game!
  end

  def input_to_method(actions, input)
    send(actions[input][:method])
  end

  def new_deck
    Deck.new
  end

  def user
    @user ||= @players.detect { |player| player.instance_of?(User) }
  end

  def dealer
    @dealer ||= @players.detect { |player| player.instance_of?(Dealer) }
  end
end
