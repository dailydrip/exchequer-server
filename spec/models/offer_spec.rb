require 'rails_helper'

RSpec.describe Offer, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:manager) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:due_on) }
    it { is_expected.to respond_to(:amount) }
    it { is_expected.to respond_to(:deferrable) }
    it { is_expected.to respond_to(:coupons) }
  end

  describe 'validations' do
    it { should validate_presence_of(:manager) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
  end

  describe 'relations' do
    it { is_expected.to have_many(:coupons) }
    it { is_expected.to have_many(:invoices) }
  end
end
