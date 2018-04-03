# frozen_string_literal: true

module ApplicationHelper
  def slack_redirect_uri
    url = if Rails.env.development?
            "http://localhost:3000/slack/oauth"
          else
            "https://www.ranked.fun/slack/oauth"
          end
    CGI.escape(url)
  end
end
