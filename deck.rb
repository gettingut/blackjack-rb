# frozen_string_literal: true

class Deck
  SUITS = {
    'Clubs' => "\u2667",
    'Diamonds' => "\u2662",
    'Hearts' => "\u2661",
    'Spades' => "\u2664"
  }.freeze
  FACE_CARDS_NAMES = %w[J Q K A].freeze
  FACE_CARDS_VALUE = 10
  ACE_VALUE = 11

  attr_reader :cards

  def initialize
    @cards = []
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
    SUITS.each do |suit, image|
      cards = build_common_cards(suit, image) + build_face_cards(suit, image)
      @cards += cards
    end
  end

  def build_common_cards(suit, image)
    (2..10).map do |value|
      new_card(name: value.to_s, suit: suit, value: value, image: image)
    end
  end

  def build_face_cards(suit, image)
    FACE_CARDS_NAMES.map do |name|
      if name == 'A'
        new_card(name: name, suit: suit, value: ACE_VALUE, image: image)
      else
        new_card(name: name, suit: suit, value: FACE_CARDS_VALUE, image: image)
      end
    end
  end

  def new_card(name:, suit:, value:, image:)
    Card.new(name: name, suit: suit, value: value, image: image)
  end
end
