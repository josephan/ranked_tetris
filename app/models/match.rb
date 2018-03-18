class Match < ApplicationRecord
  belongs_to :player_one, class_name: "User"
  belongs_to :player_two, class_name: "User"
  belongs_to :winner, class_name: "User"

  scope :confirmed, -> { where.not(winner_id: nil) }
  scope :confirmed, -> { where(winner_id: nil) }
  scope :recent, -> { order(created_at: :desc).limit(10) }

  validates_presence_of :player_one_id, :player_two_id, :player_one_won, :player_one_elo_delta, :player_two_elo_delta
end
