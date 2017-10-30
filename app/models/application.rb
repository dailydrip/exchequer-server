class Application < ApplicationRecord
  # An Application is the parent of all other objects in the data model.
  # All other data should be segmented by application.
  validates :name, presence: true
  has_many :api_keys, dependent: :destroy
end
