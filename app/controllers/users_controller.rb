# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    @matches = @user.latest_complete_matches.includes(:winner, :player_one, :player_two)
    @paginated_matches = @matches.page(params[:page])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
