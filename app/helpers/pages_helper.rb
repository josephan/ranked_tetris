# frozen_string_literal: true

module PagesHelper
  def medal(index, count)
    case index
    when 0
      "🥇"
    when 1
      "🥈"
    when 2
      "🥉"
    when count - 1
      "💩"
    else
      nil
    end
  end
end
