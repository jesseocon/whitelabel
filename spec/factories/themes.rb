FactoryBot.define do
  factory :theme do
    sequence(:name) { |n| "section-#{n}"}
  end
end