class Seat < ApplicationRecord
  belongs_to :shop

  has_many :utilization_times

  validates :number, numericality: {greater_than: 0, less_than: 999}
  validates :seat_type, length: {maximum: 30}
end
