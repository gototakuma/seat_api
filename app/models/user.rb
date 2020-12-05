class User < ApplicationRecord
  has_secure_password

  has_many :utilization_times
end
