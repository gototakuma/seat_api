class Shop < ApplicationRecord
  has_secure_password

  has_many :seats

  validates :name, length: {maximum: 30}
  validates :login_id, uniqueness: true, length: {maximum: 50}
  validates :password_digest, length: {maximum: 30}
  validates :address, length: {maximum: 50}
end
