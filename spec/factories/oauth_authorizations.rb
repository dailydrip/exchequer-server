FactoryGirl.define do
  factory :oauth_authorization do
    provider 'MyString'
    uid 'MyString'
    user
  end
end