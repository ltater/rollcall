class Team < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :games, dependent: :destroy

  validates :name, presence: true

  def upcoming_games
  	games.upcoming
  end

  def past_games
  	games.past
  end
end
