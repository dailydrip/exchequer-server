class ApiKey < ApplicationRecord
  belongs_to :application
  has_secure_token :auth_token
end
