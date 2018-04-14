# frozen_string_literal: true

class Player
  attr_reader :name
  attr_accessor :cards, :money

  def initialize(name)
    @name = name
    @money = 100
    @cards = []
  end

  def cards_value
    cards.map(&:value).inject(:+)
  end

  def alt_cards_value
    return unless aces?
    alt_values = cards.map { |card| card.name == 'A' ? 1 : card.value }
    alt_values.inject(:+)
  end

  def make_bet(money)
    @money -= money
    money
  end

  def aces?
    cards.any? { |card| card.name == 'A' }
  end

  def best_value
    return cards_value unless alt_cards_value
    cards_value <= 21 ? cards_value : alt_cards_value
  end
end
