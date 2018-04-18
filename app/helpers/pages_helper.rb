# frozen_string_literal: true

module PagesHelper
  def display_rank(rank, count)
    case rank
    when 1
      "🥇"
    when 2
      "🥈"
    when 3
      "🥉"
    when count
      "💩"
    else
      rank.ordinalize
    end
  end
end
