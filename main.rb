# frozen_string_literal: true

require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'user'
require_relative 'dealer'
require_relative 'input_validator'
require_relative 'referee'
require_relative 'controllers/main_menu_controller'
require_relative 'controllers/table_controller'
require_relative 'interface'

interface = Interface.new
controller = MainMenuController.new(interface)
controller.main_menu!
