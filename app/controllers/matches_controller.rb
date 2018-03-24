class MatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_match, only: [:show, :confirm, :destroy]

  def index
    @confirmed_matches = Match.includes(:winner, :player_one, :player_two).confirmed.paginate(page: params[:page]).latest
    @unconfirmed_matches = Match.includes(:player_one, :player_two).unconfirmed.latest
  end

  def new
    @match = Match.new
  end

  def show
    @comments = @match.comments.includes(:user).latest
    @comment = @match.comments.new
  end

  def create
    player_one = current_user
    player_two = User.find(match_params[:player_two_id])

    match = EloRating::Match.new
    if match_params[:player_one_won] == "true"
      match.add_player(rating: player_one.elo, winner: true)
      match.add_player(rating: player_two.elo)
    else
      match.add_player(rating: player_one.elo)
      match.add_player(rating: player_two.elo, winner: true)
    end
    new_player_one_elo, new_player_two_elo = match.updated_ratings

    player_one_elo_delta = new_player_one_elo - player_one.elo
    player_two_elo_delta = new_player_two_elo - player_two.elo

    extra_params = {
      player_one: current_user,
      player_one_elo_delta: player_one_elo_delta,
      player_two_elo_delta: player_two_elo_delta
    }
    @match = Match.new(match_params.merge(extra_params))

    if @match.save
      redirect_to @match, notice: "Result successfully recorded. Your opponents needs to confirm the results here: #{@match.url}"
    else
      render :new
    end
  end

  def confirm
    correct_confirmation_code = @match.confirmation_uuid == params[:confirmation_uuid]
    correct_user = @match.player_two_id == current_user.id
    if correct_confirmation_code && correct_user
      winner_id = @match.player_one_won? ? @match.player_one_id : @match.player_two_id
      @match.update(winner_id: winner_id)
      @match.player_one.update(elo: @match.player_one.elo + @match.player_one_elo_delta)
      @match.player_two.update(elo: @match.player_two.elo + @match.player_two_elo_delta)
      redirect_to @match, notice: "Thank you for confirming the match. Your elos have been updated!"
    else
      redirect_to @match, notice: "Sorry you do not have the permission to confirm this match."
    end
  end

  def destroy
    if @match.player_one_id == current_user.id && !@match.confirmed?
      @match.destroy
      redirect_to matches_url, notice: "Match successfully deleted."
    else
      redirect_to @match, alert: "You do not have the permissions to delete this match."
    end
  end

  private

  def set_match
    @match = Match.find(params[:id])
  end

  def match_params
    params.require(:match).permit(:player_one_won, :player_two_id, :player_one_rounds_won, :player_two_rounds_won)
  end
end
