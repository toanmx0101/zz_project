require 'faker'

FactoryBot.define do
  factory :order do |f|
    transient do
      first_product { FactoryBot.create(:product) }
      second_product { FactoryBot.create(:product) }
      first_qty { Faker::Number.between(1, 10) }
      second_qty { Faker::Number.between(1, 10) }
      first_o_details { FactoryBot.create(:order_detail, product_id: first_product.id, qty: first_qty) }
      second_o_details { FactoryBot.create(:order_detail, product_id: second_product.id, qty: second_qty) }
    end
    f.user_id { FactoryBot.create(:user).id }
    f.total_price { (first_product.price * first_qty) + (second_product.price * second_qty) }
  end
end
