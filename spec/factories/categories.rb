require 'faker'

FactoryBot.define do
  factory :category do |f|
    f.name { Faker::Commerce.unique.material }
    f.description { Faker::Lorem.sentence }
  end
end
