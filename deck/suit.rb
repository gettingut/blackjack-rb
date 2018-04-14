# frozen_string_literal: true

class Suit
  FACE_CARDS_NAMES = %w[J Q K A].freeze
  FACE_CARDS_VALUE = 10
  ACE_VALUE = 11

  attr_reader :cards, :image

  def initialize
    @cards = build_common_cards + build_face_cards
  end

  private

  def suit_name
    self.class.to_s
  end

  def build_common_cards
    (2..10).map do |value|
      new_card(name: value.to_s, value: value)
    end
  end

  def build_face_cards
    FACE_CARDS_NAMES.map do |name|
      if name == 'A'
        new_card(name: name, value: ACE_VALUE)
      else
        new_card(name: name, value: FACE_CARDS_VALUE)
      end
    end
  end

  def new_card(name:, value:)
    Card.new(name: name, suit: self, value: value)
  end
end
