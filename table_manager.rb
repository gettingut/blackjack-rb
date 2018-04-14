# frozen_string_literal: true

class TableManager
  include Deck

  attr_reader :players, :main

  def initialize(main)
    @main = main
    @players = main.players
    @deck = new_deck
  end

  def give_out_cards
    players.each { |player| give_cards(player, 2) }
  end

  def give_cards(player, amount)
    cards = pick_cards(amount)
    player.cards += cards
  end

  def take_bet(player, money)
    player.make_bet(money)
    replenish_bank(money)
  end

  def prepare_new_game
    players.each { |player| player.cards = [] }
    @deck = new_deck
  end

  def draw?
    over_value = user.best_value > 21 && dealer.best_value > 21
    same_value = user.best_value == dealer.best_value
    over_value || same_value
  end

  def find_winner
    players.detect { |player| winner?(player) }
  end

  private

  def user
    main.user
  end

  def dealer
    main.dealer
  end

  def replenish_bank(money)
    main.bank += money
  end

  def winner?(player)
    return if player.best_value > 21
    opponent = detect_opponent(player)
    player_value = player.best_value
    opponent_value = opponent.best_value
    if opponent_value <= 21
      player_value > opponent_value
    else
      player_value <= 21
    end
  end

  def detect_opponent(player)
    players.detect { |player_| player_ != player }
  end
end
