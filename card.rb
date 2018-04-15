# frozen_string_literal: true

class Card
  attr_reader :name, :suit, :value, :image

  def initialize(name:, suit:, value:, image:)
    @name = name
    @suit = suit
    @value = value
    @image = image
  end
end
