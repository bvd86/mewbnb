class Pokemon < ApplicationRecord
  belongs_to :user
  has_one_attached :picture

  validates :name, :rate, :description presence: true
end
