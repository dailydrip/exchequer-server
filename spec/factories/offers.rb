FactoryGirl.define do
  factory :offer do
    application
    description 'MyString'
    name 'MyString'
    due_on '2017-10-28 20:17:48'
    amount '9.99'
    deferrable false
  end
end
