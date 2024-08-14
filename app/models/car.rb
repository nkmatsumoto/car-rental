class Car < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many_attached :photos
  validates :brand, presence: true
  validates :model, presence: true
  validates :year, presence: true
  validates :rate, presence: true

  def parsed_description
    JSON.parse(description)
  end
end
