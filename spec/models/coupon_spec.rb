require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:offer) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:percent_off) }
    it { is_expected.to respond_to(:amount_off) }
  end
  describe 'validations' do
    it { should validate_presence_of(:offer) }
    it { should validate_presence_of(:name) }

    describe 'ensure a single discount type is chosen' do
      let(:coupon) { FactoryGirl.build(:coupon) }
      let(:amount_coupon) { FactoryGirl.build(:coupon, :amount) }
      let(:double_coupon) do
        FactoryGirl.build(:coupon, amount_off: 10)
      end

      it 'should only have a single discount' do
        expect(coupon).to be_valid
        expect(amount_coupon).to be_valid
        expect(double_coupon).not_to be_valid
      end
    end
  end
end
