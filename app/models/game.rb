class Game < ApplicationRecord
  belongs_to :team
  has_many :rsvps, dependent: :destroy
  has_many :players, through: :rsvps

  validates :date, :time, :location, :opponent, :home_away, presence: true
  validates :home_away, inclusion: { in: [ "home", "away" ] }

  scope :upcoming, -> { where("date >= ?", Date.today).order(date: :asc, time: :asc) }
  scope :past, -> { where("date < ?", Date.today).order(date: :desc) }

  def create_rsvps_for_team
    team.players.each do |player|
      rsvps.find_or_create_by(player: player)
    end
  end
end
