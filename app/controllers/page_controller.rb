class PageController < ApplicationController
  def home
    @users = User.ranked
    @matches = Match.recent
  end
end
