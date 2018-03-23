class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params.merge(user: current_user))
    @comment.save
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :match_id)
  end
end
