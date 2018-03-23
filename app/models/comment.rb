class Comment < ApplicationRecord
  belongs_to :match, counter_cache: true
  belongs_to :user

  validates_length_of :body, minimum: 1, maximum: 250, allow_blank: false

  scope :latest, -> { order(created_at: :desc) }
end
