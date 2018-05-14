# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authenticate_user!, only: %i[profile update_profile]

  def home
    @ranked_users = User.active.ranked
    @unranked_users = User.active.unranked
    @matches = Match.includes(:winner, :player_one, :player_two).confirmed.recent
  end

  def hall_of_fame
    @retired_users = User.where(retired: true)
  end

  def profile
  end

  def update_profile
    if current_user.update(user_params)
      redirect_to profile_url, notice: "Your account has been updated!"
    else
      render "profile"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :avatar)
  end
end
