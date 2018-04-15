# frozen_string_literal: true

module Interface
  class BasicInterface
    include UserActions

    def initialize(main)
      @main = main
    end

    def perform
      print_actions
      @input = input_action
      return unless input
      actions_to_method(input)
    end

    protected

    attr_reader :main

    def players
      main.players
    end

    def user
      main.user
    end

    def dealer
      main.dealer
    end

    def bank
      main.bank
    end
  end
end
