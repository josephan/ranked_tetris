# frozen_string_literal: true

class User < ApplicationRecord
  before_create :set_default_elo

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :won_matches, class_name: 'Match', foreign_key: 'winner_id'
  has_many :comments

  validates :name, presence: true

  scope :ranked, -> { order(elo: :desc) }
  scope :everyone_else, ->(current_user) { where.not(id: current_user.id) }

  def complete_matches
    @complete_matches ||= Match.where.not(winner_id: nil).where('player_one_id = ? OR player_two_id = ?', id, id)
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

  def first_and_last
    split_name = name.split(' ')
    return name.capitalize if split_name.length < 2
    first_name = split_name.first.capitalize
    last_name_letter = split_name.last[0].upcase
    "#{first_name} #{last_name_letter}."
  end

  def win_ratio
    if @complete_matches.count > 0
      "#{(@wins.to_f / @complete_matches.count * 100).round}%"
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
