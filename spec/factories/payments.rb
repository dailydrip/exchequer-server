FactoryGirl.define do
  factory :payment do
    invoice
    amount BigDecimal.new('10.00')
  end
end
