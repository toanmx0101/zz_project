require 'faker'

FactoryBot.define do
  factory :order do |f|
    f.user_id { FactoryBot.create(:user).id }
    f.order_details { { FactoryBot.create(:product).id => Faker::Number.between(1, 10), FactoryBot.create(:product).id => Faker::Number.between(1, 10) } }
  end
end
