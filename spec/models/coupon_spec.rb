require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:offer) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:code) }
    it { is_expected.to respond_to(:percent_off) }
    it { is_expected.to respond_to(:amount_off) }
  end

  describe 'validations' do
    it { should validate_presence_of(:offer) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:code) }

    describe 'ensure a single discount type is chosen' do
      let(:coupon) { FactoryGirl.build(:coupon) }
      let(:amount_coupon) { FactoryGirl.build(:coupon, :amount) }
      let(:double_coupon) do
        FactoryGirl.build(:coupon, amount_off: 10)
      end

      it 'only has a single discount' do
        expect(coupon).to be_valid
        expect(amount_coupon).to be_valid
        expect(double_coupon).not_to be_valid
      end
    end
  end

  describe '#discounted_price' do
    let(:offer) { FactoryGirl.create(:offer, amount: 100) }

    context 'when offer has amount off' do
      let(:coupon) { FactoryGirl.create(:coupon, amount_off: 20, percent_off: nil) }
      it 'returns the amount off as a discount price' do
        expect(coupon.discounted_price).to eq 20
      end
    end

    context 'when offer has percent off' do
      let(:coupon) { FactoryGirl.create(:coupon, amount_off: nil, percent_off: 0.2) }
      it 'returns the offer amount * percent off as a discount price' do
        expect(coupon.discounted_price).to eq 0.2
      end
    end
  end
end
