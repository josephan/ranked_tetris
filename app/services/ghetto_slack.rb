module GhettoSlack
  BASE_URI = "https://slack.com/api".freeze
  HEADERS = {
    "Content-Type" => "application/json",
    "charset" => "utf-8"
  }.freeze

  def self.send_message(message)
    webhook_url = ENV["SLACK_WEBHOOK_URL"]
    return unless webhook_url.present?

    options = {
      body: {
        text: message
      }.to_json,
      headers: HEADERS
    }

    HTTParty.post(
      webhook_url,
      options
    )
  end

  def self.send_to_user(user, message)
    return unless user.slack?

    options = {
      body: {
        text: message
      }.to_json,
      headers: HEADERS
    }

    HTTParty.post(
      user.slack_webhook_url,
      options
    )
  end
end
