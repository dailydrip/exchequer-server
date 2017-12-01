require 'rails_helper'

RSpec.describe LineItem, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:invoice) }
    it { is_expected.to respond_to(:quantity) }
    it { is_expected.to respond_to(:amount) }
    it { is_expected.to respond_to(:offer) }
    it { is_expected.to respond_to(:coupon) }
  end
  describe 'validations' do
    it { should validate_presence_of(:invoice) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:amount) }

    describe '#type' do
      context 'when the lineitem is for Coupon' do
        let(:line_item) { FactoryGirl.create(:line_item, coupon_id: 1, offer_id: nil) }
        it 'returns the Coupon class' do
          expect(line_item.type).to eq Coupon
        end
      end

      context 'when the lineitem is for Offer' do
        let(:line_item) { FactoryGirl.create(:line_item, coupon_id: nil, offer_id: 1) }
        it 'returns the Offer class' do
          expect(line_item.type).to eq Offer
        end
      end
    end

    describe '#ensure_non_dual_type' do
      let(:dual_line_item) do
        FactoryGirl.build(:line_item, coupon: FactoryGirl.create(:coupon))
      end

      it 'ensures a line item with both types are invalid' do
        expect(dual_line_item).not_to be_valid
      end
    end
    describe '#ensure_single_type' do
      let(:line_item) { FactoryGirl.build(:line_item) }
      let(:coupon_line_item) { FactoryGirl.build(:line_item, :as_coupon) }
      let(:typeless_line_item) { FactoryGirl.build(:line_item, offer: nil) }

      it 'ensures type is chosen' do
        expect(line_item).to be_valid
        expect(coupon_line_item).to be_valid
        expect(typeless_line_item).not_to be_valid
      end
    end
  end
end
