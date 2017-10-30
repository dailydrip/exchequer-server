FactoryGirl.define do
  factory :offer do
    application
    description 'MyString'
    name 'MyString'
    due_on '2017-10-28 20:17:48'
    amount BigDecimal.new('100.00')
    deferrable false
  end
end
