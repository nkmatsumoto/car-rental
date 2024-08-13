class Car < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_one_attached :photo
  validates :brand, presence: true
  validates :model, presence: true
  validates :year, presence: true
  validates :rate, presence: true
end
