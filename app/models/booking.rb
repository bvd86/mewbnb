class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :pokemon

  validates :status, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
