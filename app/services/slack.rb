module Slack
  def self.send_message(message)
    webhook_url = ENV["SLACK_WEBHOOK_URL"]
    return unless webhook_url.present?

    options = {
      body: {
        text: message
      },
      headers: {
        "Content-type" => "application/json"
      }
    }

    HTTParty.post(
      webhook_url,
      options
    )
  end
end
