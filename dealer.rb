# frozen_string_literal: true

class Dealer < Player
  def initialize
    super('Dealer')
  end

  def take_card?
    if aces?
      best_value < 17
    else
      cards_value < 17
    end
  end
end
