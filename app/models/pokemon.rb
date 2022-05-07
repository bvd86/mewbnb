class Pokemon < ApplicationRecord
  belongs_to :user
  has_one :booking, dependent: :destroy
  has_one_attached :picture

  validates :name, presence: true
  validates :pokemon_type, presence: true
  validates :level, presence: true
  validates :location, presence: true
  validates :rate, presence: true
  validates :description, presence: true

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  include PgSearch::Model
  pg_search_scope :search_by_name_and_description,
    against: [ :name, :description ],
    using: {
      tsearch: { prefix: true }
    }
end
