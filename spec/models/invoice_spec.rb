require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:offer) }
    it { is_expected.to respond_to(:user) }
    it { is_expected.to respond_to(:payments) }
    it { is_expected.to respond_to(:line_items) }
    it { is_expected.to respond_to(:due_on) }
  end
  describe 'validations' do
    it { should validate_presence_of(:offer) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:due_on) }
  end

  describe '#paid_balance' do
    pending 'implement and test out #paid_balance'
  end

  describe '#subtotal' do
    pending 'implement and test out #subtotal'
  end

  describe '#total' do
    pending 'implement and test out #total'
  end

  describe '#remaining_balance' do
    pending 'implement and test out #remaining_balance'
  end
end
