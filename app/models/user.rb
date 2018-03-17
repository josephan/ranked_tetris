class User < ApplicationRecord
  before_create :set_default_elo

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :won_matches, class_name: "Match", foreign_key: "winner_id"

  validates :name, presence: true

  scope :ranked, -> { order(elo: :desc) }

  def matches
    Match.where("player_one_id = ? OR player_two_id = ?", self.id, self.id)
  end

  def wins
    self.won_matches.count
  end

  def losses
    self.matches.count - self.wins
  end

  private

  def set_default_elo
    self.elo = 2000
  end
end
