# frozen_string_literal: true

class Match < ApplicationRecord
  belongs_to :player_one, class_name: 'User'
  belongs_to :player_two, class_name: 'User'
  belongs_to :winner, class_name: 'User', optional: true

  has_many :comments, dependent: :destroy

  scope :confirmed, -> { where.not(winner_id: nil) }
  scope :unconfirmed, -> { where(winner_id: nil) }
  scope :recent, -> { order(created_at: :desc).limit(10) }
  scope :latest, -> { order(created_at: :desc) }

  validates_presence_of :player_one_id, :player_two_id, :player_one_elo_delta, :player_two_elo_delta
  validates :player_one_won, inclusion: { in: [true, false] }
  validates :player_one_rounds_won, inclusion: { in: 0..3 }
  validates :player_two_rounds_won, inclusion: { in: 0..3 }

  validate :player_one_and_player_two_is_different
  validate :one_of_the_players_must_win_3_rounds
  validate :neither_of_the_players_can_win_3_rounds
  validate :winner_has_3_rounds_won

  before_create :generate_confirmation_uuid

  def confirmed?
    winner_id.present?
  end

  def date
    created_at.strftime('%b %e, %Y %l:%M%P')
  end

  def winner
    if winner_id
      super
    else
      player_one_won? ? player_one : player_two
    end
  end

  def loser
    winner.id == player_one_id ? player_two : player_one
  end

  def winner_delta
    player_delta = player_one_is_winner? ? player_one_elo_delta : player_two_elo_delta
    "+#{player_delta}"
  end

  def loser_delta
    player_delta = player_one_is_winner? ? player_two_elo_delta : player_one_elo_delta
    player_delta.to_s
  end

  def player_one_is_winner?
    winner.id == player_one.id
  end

  def url
    "https://www.ranked.fun/matches/#{id}"
  end

  def result
    "#{winner_rounds_won} - #{loser_rounds_won}"
  end

  def winner_rounds_won
    player_one_is_winner? ? player_one_rounds_won : player_two_rounds_won
  end

  def loser_rounds_won
    player_one_is_winner? ? player_two_rounds_won : player_one_rounds_won
  end

  def opponent_of(player)
    return if player.id != player_one_id && player.id != player_two_id
    player.id == player_one_id ? player_two : player_one
  end

  def message
    if confirmed?
      "#{winner.first_and_last} just beat #{loser.first_and_last} (#{result})\n<#{url}|Click Here> for details!"
    end
  end

  private

  def generate_confirmation_uuid
    self.confirmation_uuid = SecureRandom.uuid
  end

  def player_one_and_player_two_is_different
    errors.add(:player_two_id, 'cannot be the same as player one') if player_one_id == player_two_id
  end

  def one_of_the_players_must_win_3_rounds
    errors.add(:base, :none_3_rounds, message: 'one of the players must have won 3 rounds') if player_one_rounds_won != 3 && player_two_rounds_won != 3
  end

  def neither_of_the_players_can_win_3_rounds
    errors.add(:base, :both_3_rounds, message: "both players can't have won 3 rounds") if player_one_rounds_won > 2 && player_two_rounds_won > 2
  end

  def winner_has_3_rounds_won
    if player_one_won? && player_one_rounds_won != 3
      errors.add(:base, :player_one_won, message: 'you claimed you won but did not set the number of rounds won to 3 for yourself')
    elsif !player_one_won? && player_two_rounds_won != 3
      errors.add(:base, :player_one_won, message: 'you claimed you lost but did not set the number of rounds won to 3 for your opponent')
    end
  end
end
