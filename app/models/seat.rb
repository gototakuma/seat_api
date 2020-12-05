class Seat < ApplicationRecord
  belongs_to :shop

  has_many :utilization_times
end
