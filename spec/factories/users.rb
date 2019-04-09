FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "jesse+#{n}@masterclass.com" }
    password 'password'
    password_confirmation 'password'
  end
end
