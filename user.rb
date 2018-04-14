# frozen_string_literal: true

class User < Player
  NAME_REGEXP = /^[a-zA-Zа-яА-Я]{0,10}$/
  NAME_ERROR = "Name doesn't match Regexp."

  def initialize(name)
    validate_name(name)
    super
  end

  private

  def validate_name(name)
    raise ArgumentError, NAME_ERROR unless name =~ NAME_REGEXP
  end
end
