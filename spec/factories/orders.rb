require 'faker'

FactoryBot.define do
  factory :order do |f|
    transient do
      product_1 { FactoryBot.create(:product) }
      product_2 { FactoryBot.create(:product) }
      qty_1 { Faker::Number.between(1, 10) }
      qty_2 { Faker::Number.between(1, 10) }
    end
    f.user_id { FactoryBot.create(:user).id }
    f.order_details { { product_1.id =>  qty_1, product_2.id => qty_2 } }
    f.total_price { (product_1.price * qty_1) + (product_2.price * qty_2) }
  end
end
