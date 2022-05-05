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
end
