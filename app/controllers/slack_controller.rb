class SlackController < ApplicationController
  before_action :authenticate_user!

  def oauth
    body = {
      "client_id"=> ENV["SLACK_CLIENT_ID"],
      "client_secret"=> ENV["SLACK_CLIENT_SECRET"],
      "code"=> params["code"]
    }
    resp = HTTParty.post("https://slack.com/api/oauth.access", body: body)
    if resp.code == 200
      parsed_resp = JSON.parse(resp.body)
      current_user.update(
        slack_webhook_url: parsed_resp["incoming_webhook"]["url"],
      )
      flash["notice"] = "Successfully added Slack!"
      GhettoSlack.send_to_user(current_user, "Greetings Comrade! I will keep you posted about your latest matches.")
    else
      flash["alert"] = "Oops something went wrong. No Slack! Hehehe 🤡"
    end
    redirect_to profile_url
  end

  def destroy
    if current_user.slack?
      current_user.update(
        slack_webhook_url: nil,
      )
    end
    flash["notice"] = "Successfully removed Slack!"
    redirect_to profile_url
  end
end
