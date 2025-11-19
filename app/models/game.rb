class Game < ApplicationRecord
  belongs_to :home_team, class_name: "Team", foreign_key: "home_team_id"
  belongs_to :away_team, class_name: "Team", foreign_key: "away_team_id"

  validates :date, :time, :location, :home_team_id, :away_team_id, presence: true
  validate :teams_must_be_different

  private

  def teams_must_be_different
    if home_team_id == away_team_id
      errors.add(:base, "Home team and away team must be different")
    end
  end
end
