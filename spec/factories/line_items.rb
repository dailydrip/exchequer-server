FactoryGirl.define do
  factory :line_item do
    invoice
    quantity 1
    amount BigDecimal.new('10.00')
    offer
    trait :as_coupon do
      offer nil
      coupon
    end
  end
end
