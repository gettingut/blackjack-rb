# frozen_string_literal: true

require_relative 'deck'
require_relative 'interface'
require_relative 'player'
require_relative 'user'
require_relative 'dealer'
require_relative 'table_manager'

class Main
  include Interface

  attr_accessor :players, :bank

  def initialize
    @players = []
    @bank = 0
    main_menu_interface.perform
  end

  def user
    @user ||= detect(User)
  end

  def dealer
    @dealer ||= detect(Dealer)
  end

  private

  def detect(player_class)
    players.detect { |player| player.instance_of?(player_class) }
  end

  def main_menu_interface
    MainMenuInterface.new(self)
  end
end

Main.new