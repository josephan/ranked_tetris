class MatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_match, only: [:show]

  def index
    @confirmed_matches = Match.confirmed
  end

  def new
    @match = Match.new
  end

  def show
  end

  def create
    player_one = current_user
    player_two = User.find(match_params[:player_two_id])

    match = EloRating::Match.new
    if match_params[:player_one_won]
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
    require 'pry'; binding.pry
    @match = Match.new(match_params.merge(extra_params))

    if @match.save
      redirect_to @match, notice: "Match result created. An email has been sent to your opponent for confirmation. Or you can send him this link #{"https://www.ranked.fun/matches/#{match_id}"}"
    else
      render :new
    end
  end

  private

  def set_match
    @match = Match.find(params[:id])
  end


  def match_params
    params.require(:match).permit(:player_one_won, :player_two_id)
  end
end
