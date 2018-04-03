# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params.merge(user: current_user))
    @match = Match.includes(:player_one, :player_two).find(comment_params[:match_id])
    GhettoSlack.send_to_user(@match.player_one, message) if @match.player_one != current_user
    GhettoSlack.send_to_user(@match.player_two, message) if @match.player_two != current_user
    @comment.save
  end

  private

  def message
    "#{current_user.first_and_last} just commented in your match! (<#{@match.url}|read comment>)"
  end

  def comment_params
    params.require(:comment).permit(:body, :match_id)
  end
end
