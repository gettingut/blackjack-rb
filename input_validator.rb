# frozen_string_literal: true

module InputValidator
  private

  def check_input(actions, input)
    raise 'Wrong action number!' unless valid_input?(actions, input)
  end

  def valid_input?(actions, input)
    !actions[input].nil?
  end
end
