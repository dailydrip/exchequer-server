FactoryGirl.define do
  factory :offer do
    application
    description 'MyString'
    name 'MyString'
    due_on 'MyString'
    datetime 'MyString'
    amount '9.99'
    deferrable false
  end
end
