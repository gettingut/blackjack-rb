module UserActions
  private

  UNKNOWN_ACTION = "Unknown action.\n\n"

  attr_reader :input

  def print_actions
    puts actions_title
    actions.each { |num, action| puts "\t#{num}: #{action[:text]}" }
  end

  def actions
    {}
  end

  def input_action
    action = gets.chomp.to_i
    if valid_action?(action)
      action
    else
      puts UNKNOWN_ACTION
      input_action
    end
  end

  def actions_to_method(action)
    send(actions[action][:method])
  end

  def valid_action?(action)
    actions.keys.include?(action)
  end
end
