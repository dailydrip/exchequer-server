require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  it { should validate_presence_of(:application) }
  it { should validate_presence_of(:auth_token) }
end
