class Car < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many_attached :photos
  validates :brand, presence: true
  validates :model, presence: true
  validates :year, presence: true
  validates :rate, presence: true

  include PgSearch::Model

  pg_search_scope :search_by,
    against: [:brand, :model, :year],
    associated_against: {
      user: [:address]
    },
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

  def parsed_description
    JSON.parse(description)
  end
end
