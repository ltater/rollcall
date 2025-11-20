class Game < ApplicationRecord
  belongs_to :home_team, class_name: "Team", foreign_key: "home_team_id"
  belongs_to :away_team, class_name: "Team", foreign_key: "away_team_id"

  has_many :rsvps, dependent: :destroy
  has_many :players_rsvped, through: :rsvps, source: :player

  validates :date, :time, :location, :home_team_id, :away_team_id, presence: true
  validate :teams_must_be_different

  def all_team_players
    (home_team.players + away_team.players).uniq
  end

  def create_rsvps_for_players
    all_team_players.each do |player|
      rsvps.find_or_create_by(player: player)
    end
  end

  def team_rsvps(team)
    if home_team_id == away_team_id
      errors.add(:base, "Home team and away team must be different")
    end
  end

  private

  def teams_must_be_different
    if home_team_id == away_team_id
      errors.add(:base, "Home team and away team must be different")
    end
  end
end
