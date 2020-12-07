class User < ApplicationRecord
  has_secure_password

  has_many :utilization_times
  validates :name, length: {maximum: 30}
  validates :login_id, uniqueness: true, length: {maximum: 50}
  validates :password_digest, length: {maximum: 30}
end
