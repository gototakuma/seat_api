class Message < ApplicationRecord
  validates :title, length: {maximum: 30}
  validates :description, length: {maximum: 500}
end
