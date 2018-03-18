class Match < ApplicationRecord
  belongs_to :player_one, class_name: "User"
  belongs_to :player_two, class_name: "User"
  belongs_to :winner, class_name: "User", optional: true

  scope :confirmed, -> { where.not(winner_id: nil) }
  scope :unconfirmed, -> { where(winner_id: nil) }
  scope :recent, -> { order(created_at: :desc).limit(10) }

  validates_presence_of :player_one_id, :player_two_id, :player_one_won, :player_one_elo_delta, :player_two_elo_delta
  validate :player_one_and_player_two_is_different

  private

  def player_one_and_player_two_is_different
    errors.add(:player_two_id, "cannot be the same as player one") if player_one_id == player_two_id
  end
end
