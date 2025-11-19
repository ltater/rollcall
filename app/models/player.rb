class Player < ApplicationRecord
    belongs_to :team, optional: true # optional: true allows players without a team
    has_many :rsvps, dependent: :destroy
    has_many :games, through: :rsvps

    validates :name, :phone, presence: true
end
