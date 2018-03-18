class Match < ApplicationRecord
  belongs_to :player_one, class_name: "User"
  belongs_to :player_two, class_name: "User"
  belongs_to :winner, class_name: "User", optional: true

  scope :confirmed, -> { where.not(winner_id: nil) }
  scope :unconfirmed, -> { where(winner_id: nil) }
  scope :recent, -> { order(created_at: :desc).limit(10) }

  validates_presence_of :player_one_id, :player_two_id, :player_one_elo_delta, :player_two_elo_delta
  validates :player_one_won, inclusion: { in: [true, false] }
  validate :player_one_and_player_two_is_different

  before_create :generate_confirmation_uuid

  def confirmed?
    winner_id.present?
  end

  def date
    created_at.strftime("%b %e, %Y %l:%M%P")
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
    player_delta = if player_one_is_winner?
                     player_one_elo_delta
                   else
                     player_two_elo_delta
                   end
    "+#{player_delta}"
  end

  def loser_delta
    player_delta = if player_one_is_winner?
                     player_two_elo_delta
                   else
                     player_one_elo_delta
                   end
    "#{player_delta}"
  end

  def player_one_is_winner?
    winner.id == player_one.id
  end

  def url
    "https://www.ranked.fun/match/#{id}"
  end

  private

  def generate_confirmation_uuid
    self.confirmation_uuid = SecureRandom.uuid
  end

  def player_one_and_player_two_is_different
    errors.add(:player_two_id, "cannot be the same as player one") if player_one_id == player_two_id
  end
end
