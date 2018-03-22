require 'faker'

FactoryBot.define do
  factory :order_details do |f|
    f.order_id { FactoryBot.create(:order) }
    f.product_id { FactoryBot.create(:product) }
    f.qty { Faker::Number.between(1, 10) }
  end
end
