class PagesController < ApplicationController
  def home
    @users = User.ranked
    @matches = Match.confirmed.recent
  end
end
