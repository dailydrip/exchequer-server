require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:invoice) }
    it { is_expected.to respond_to(:amount) }
  end
  describe 'validations' do
    it { should validate_presence_of(:invoice) }
    it { should validate_presence_of(:amount) }
  end
end
