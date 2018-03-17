class PagesController < ApplicationController
  def home
    @users = User.ranked
    @completed_matches = Match.recent
    @upcoming_matches = Match.all
  end
end
