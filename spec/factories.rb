require 'factory_girl'

FactoryGirl.define do
  sequence(:email) {|n| "person#{n}@example.com" }

  factory :user do
    email { generate(:email) }
    password 'changeme'
    password_confirmation 'changeme'
  end

  factory :news do
    title "test news"
    body "long long long body"
    user
  end
end
