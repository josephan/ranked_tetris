# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @users = User.ranked
    @matches = Match.includes(:winner, :player_one, :player_two).confirmed.recent
  end
end
