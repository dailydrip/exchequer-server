FactoryGirl.define do
  factory :coupon do
    offer
    name { Faker::Lorem.word }
    percent_off 10
    trait :amount do
      percent_off nil
      amount_off 10
    end
  end
end
