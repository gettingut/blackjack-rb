# frozen_string_literal: true

class TableController
  include InputValidator
  include Referee

  INGAME_ACTIONS = {
    1 => { text: 'Check', method: :user_checks },
    2 => { text: 'Take card', method: :user_takes_card },
    3 => { text: 'Show your cards', method: :show_cards }
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
    interface.show_game_table(players, bank, dealer_hidden: true)
    make_bets
    interface.show_game_table(players, bank, dealer_hidden: true)
    user_actions_interface(INGAME_ACTIONS)
  end

  private

  def give_out_cards
    players.each { |player| give_cards(player, 2, message: false) }
  end

  def give_cards(player, amount, message: true)
    cards = @deck.pick_cards(amount)
    player.cards += cards
    interface.took_card_message(player) if message
  end

  def make_bets
    interface.making_bets_message
    players.each { |player| take_bet(player, 10) }
    sleep(1)
  end

  def take_bet(player, money)
    player.make_bet(money)
    @bank += money
  end

  def user_actions_interface(actions)
    interface.show_user_actions(actions)
    user_action = interface.receive_action
    check_input(actions, user_action)
    input_to_method(actions, user_action)
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def user_checks
    dealer_turn
    if dealer.cards.size > 2
      show_cards
    else
      interface.show_game_table(players, bank, dealer_hidden: true)
      user_actions_interface(ENDGAME_ACTIONS)
    end
  end

  def user_takes_card
    give_cards(user, 1)
    dealer_turn
    show_cards
  end

  def dealer_turn
    give_cards(dealer, 1) if dealer.take_card?
  end

  def show_cards
    interface.show_game_table(players, bank)
    compare_players_results
    user_actions_interface(ENDGAME_ACTIONS)
  end

  def compare_players_results
    if draw?(players)
      handle_draw
    else
      winner = find_winner(players)
      handle_win(winner)
    end
  end

  def handle_draw
    interface.draw_message
    prize = bank / 2
    user.money += prize
    dealer.money += prize
    @bank = 0
  end

  def handle_win(player)
    interface.win_message(player, bank)
    player.money += bank
    @bank = 0
  end

  def play_again
    players.each { |player| player.cards = [] }
    @deck = new_deck
  end

  def input_to_method(actions, input)
    method = actions[input][:method]
    send(method)
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
