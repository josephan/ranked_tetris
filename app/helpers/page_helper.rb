module PageHelper
  def win_or_lose_indicator(player_id, winner_id)
    if player_id == winner_id
      "🏆"
    else
      "☠️"
    end
  end
end
