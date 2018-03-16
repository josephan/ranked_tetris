class Match < ApplicationRecord
  belongs_to :player_one, class_name: "User"
  belongs_to :player_two, class_name: "User"
  belongs_to :winner, class_name: "User"

  scope :recent, -> { order(start_date: :desc).limit(10) }
end
