class ApiKey < ApplicationRecord
  belongs_to :application
  has_secure_token :auth_token
  validates :application, presence: true
  validates :auth_token, presence: true
end
