require 'faker'

FactoryBot.define do
  factory :product do |f|
    f.name { Faker::Commerce.unique.product_name }
    f.price { Faker::Commerce.price }
    f.description { Faker::Lorem.sentence }
    f.category_id { FactoryBot.create(:category).id }
  end
end
