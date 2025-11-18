class Player < ApplicationRecord
    validates :name, :phone, presence: true
    belongs_to :team, optional: true # optional: true allows players without a team
end
