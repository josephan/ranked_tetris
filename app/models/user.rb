# frozen_string_literal: true

class User < ApplicationRecord
  before_create :set_default_elo

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :won_matches, class_name: 'Match', foreign_key: 'winner_id'
  has_many :comments

  has_one_attached :avatar

  validates :name, presence: true

  scope :active, -> { where(retired: false) }
  scope :everyone_else, ->(current_user) { where.not(id: current_user.id).order(:name) }

  def self.ranked
    order(elo: :desc).select do |user|
      user.complete_matches.count >= 5 && user.complete_matches.last.created_at >= 1.week.ago
    end
  end

  def self.unranked
    where.not(id: ranked).order(:created_at)
  end

  def complete_matches
    @complete_matches ||= Match.confirmed.where('player_one_id = ? OR player_two_id = ?', id, id).order(created_at: :asc)
  end

  def latest_complete_matches
    @latest_complete_matches ||= Match.confirmed.where('player_one_id = ? OR player_two_id = ?', id, id).order(created_at: :desc)
  end

  def wins
    @wins ||= won_matches.count
  end

  def losses
    @losses ||= complete_matches.count - wins
  end

  def first_name
    name.split(' ').first.capitalize
  end

  def default_avatar
    "tetris#{default_image}.png"
  end

  def first_and_last
    split_name = name.split(' ')
    return name.capitalize if split_name.length < 2
    first_name = split_name.first.capitalize
    last_name_letter = split_name.last[0].upcase
    "#{first_name} #{last_name_letter}."
  end

  def win_loss_streak
    return "-" if complete_matches.blank?
    last_match_won = complete_matches.last.winner_id == id
    streak = complete_matches.reverse.take_while { |match| (id == match.winner_id && last_match_won) || (id != match.winner_id && !last_match_won) }.count
    "#{last_match_won ? "W" : "L"}#{streak}"
  end

  def win_ratio
    if complete_matches.count > 0
      "#{(@wins.to_f / complete_matches.count * 100).round}%"
    else
      '-'
    end
  end

  def slack?
    slack_webhook_url.present?
  end

  private

  def set_default_elo
    self.elo = 2000
  end
end
