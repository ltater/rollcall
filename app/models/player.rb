class Player < ApplicationRecord
    validates :name, :phone, presence: true
end
