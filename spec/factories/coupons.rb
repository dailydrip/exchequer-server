FactoryGirl.define do
  factory :coupon do
    offer
    name 'Super Awesome Coupon'
    percent_off 10
    trait :amount do
      percent_off nil
      amount_off 10
    end
  end
end
