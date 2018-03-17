class Match < ApplicationRecord
  belongs_to :player_one, class_name: "User"
  belongs_to :player_two, class_name: "User"
  belongs_to :winner, class_name: "User"

  scope :recent, -> { order(start_date: :desc).limit(10) }
  scope :completed, -> { where.not(winner_id: nil) }
  scope :not_yet_started, -> { where(winner_id: nil) }
  scope :upcoming, -> { where("start_date >= ?", Time.zone.now) }
end
