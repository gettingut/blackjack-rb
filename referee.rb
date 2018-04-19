# frozen_string_literal: true

module Referee
  private

  WIN_SCORE = 21

  def draw?(players)
    same_values?(players) || fail_values?(players)
  end

  def winner?(player)
    return if player.best_value > WIN_SCORE
    opponent = detect_opponent(player)
    player_value = player.best_value
    opponent_value = opponent.best_value
    if opponent_value <= WIN_SCORE
      player_value > opponent_value
    else
      player_value <= WIN_SCORE
    end
  end

  def find_winner(players)
    players.detect { |player| winner?(player) }
  end

  def detect_opponent(player)
    players.detect { |player_| player_ != player }
  end

  def fail_values?(players)
    players.all? { |player| player.best_value > WIN_SCORE }
  end

  def same_values?(players)
    players.map(&:best_value).uniq.size == 1
  end
end
