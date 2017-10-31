class ApiKey < ApplicationRecord
  # API Keys belong to an Applications and are used to interface with the API
  # We use the Rails 5 has_secure_token methods to generate the token
  belongs_to :app
  has_secure_token :auth_token
  validates :app, presence: true
end
