module MatchesHelper
  def extra_info(is_winner:, match:, type:)
    case type
    when :elo_delta
      elo_delta_extra_info(is_winner, match)
    when :unconfirmed
      unconfirmed_extra_info(is_winner, match)
    else
      nil
    end
  end

  def elo_delta_extra_info(is_winner, match)
    if is_winner
      content_tag(:span, match.winner_delta, class: "green-text")
    else
      content_tag(:span, match.loser_delta, class: "red-text")
    end
  end

  def unconfirmed_extra_info(is_winner, match)
    return if is_winner && match.player_one_is_winner?
    return if !is_winner && !match.player_one_is_winner?
    "❌"
  end

  def extra_table_th(type, value)
    case type
    when :elo_delta
      content_tag(:th, value)
    else
      nil
    end
  end

  def extra_table_td(type, value)
    case type
    when :elo_delta
      content_tag(:th, value)
    else
      nil
    end
  end
end
