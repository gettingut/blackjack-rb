# frozen_string_literal: true

class MainMenuController
  include InputValidator

  MAIN_MENU_ACTIONS = {
    1 => { text: 'Play', method: :new_game },
    2 => { text: 'Exit', method: :exit }
  }.freeze

  attr_reader :interface, :players

  def initialize(interface)
    @interface = interface
    @players = []
  end

  def main_menu!
    interface.show_main_menu(MAIN_MENU_ACTIONS)
    play_or_exit_input = interface.receive_action
    check_input(MAIN_MENU_ACTIONS, play_or_exit_input)
    method = MAIN_MENU_ACTIONS[play_or_exit_input][:method]
    send(method)
  rescue RuntimeError => e
    puts e.message
    retry
  end

  private

  def new_game
    interface.enter_name_message
    name = interface.receive_name
    players << new_user(name)
    players << new_dealer
    loop { table_controller.start_new_game! }
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
