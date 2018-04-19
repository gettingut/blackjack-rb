# frozen_string_literal: true

class MainMenuController
  attr_reader :interface, :players

  def initialize(interface)
    @interface = interface
    @players = []
  end

  def main_menu!
    actions = {
      1 => { text: 'Play', method: :new_game },
      2 => { text: 'Exit', method: :exit }
    }
    interface.show_main_menu(actions)
    input = interface.receive_action
    input_to_method(actions, input)
  end

  private

  def new_game
    interface.new_player
    name = interface.receive_name
    players << new_user(name)
    players << new_dealer
    table_controller.start_new_game!
  end

  def input_to_method(actions, input)
    send(actions[input][:method])
  end

  def exit
    Kernel.exit
  end

  def new_dealer
    Dealer.new
  end

  def new_user(name)
    User.new(name)
  end

  def table_controller
    TableController.new(players, interface)
  end
end
