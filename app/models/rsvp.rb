class Rsvp < ApplicationRecord
  belongs_to :game
  belongs_to :player

  STATUSES = ['pending', 'yes', 'no'].freeze

  validates :status, inclusion: { in: STATUSES }
  validates :player_id, uniqueness: { scope: :game_id }

  scope :yes, -> { where(status: 'yes') }
  scope :no, -> { where (status: 'no') }
  scope :pending, -> { where(status: 'pending') } 
end
