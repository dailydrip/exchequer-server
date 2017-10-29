FactoryGirl.define do
  factory :line_item do
    invoice
    quantity 1
    amount '9.99'
    trait :offer do
      offer
    end
    trait :coupon do
      coupon
    end
  end
end
