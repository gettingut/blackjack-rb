# frozen_string_literal: true

require_relative 'deck/card'
require_relative 'deck/suit'
require_relative 'deck/diamonds'
require_relative 'deck/hearts'
require_relative 'deck/clubs'
require_relative 'deck/spades'

module Deck
  attr_reader :cards

  def new_deck
    build_deck
    shuffle
  end

  def shuffle
    cards.shuffle!
  end

  def pick_cards(amount)
    cards.pop(amount)
  end

  private

  def build_deck
    @cards = hearts.cards + diamonds.cards + clubs.cards + spades.cards
  end

  def hearts
    @hearts ||= Hearts.new
  end

  def diamonds
    @diamonds ||= Diamonds.new
  end

  def clubs
    @clubs ||= Clubs.new
  end

  def spades
    @spades ||= Spades.new
  end
end
