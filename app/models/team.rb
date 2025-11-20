class Team < ApplicationRecord
  validates :name, presence: true
  has_many :players, dependent: :destroy
  has_many :home_games, class_name: "Game", foreign_key: "home_team_id", dependent: :destroy
  has_many :away_games, class_name: "Game", foreign_key: "away_team_id", dependent: :destroy

  def games
    Game.where("home_team_id = ? OR away_team_id = ?", id, id)
      .order(date: :asc, time: :asc)
  end

  def upcoming_games
    games.where("date >= ?", Date.today)
  end
end
