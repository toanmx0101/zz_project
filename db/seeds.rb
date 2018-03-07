Rails.logger.info('Start Seed')
Rails.logger.info('Category and Product Seed')

10.times do
  category = Category.new
  category.name = Faker::Commerce.unique.material
  category.description = Faker::Lorem.sentence
  category.save
  10.times do
    product = Product.new
    product.name = Faker::Commerce.unique.product_name
    product.price = Faker::Commerce.price
    product.description = Faker::Lorem.sentence
    product.category = category
    product.save
  end
end
Rails.logger.infor('End Seed')

User.create email: 'zinza1@gmail.com', password: 'zinza123@', password_confirmation: 'zinza123@'
User.create email: 'zinza2@gmail.com', password: 'zinza123@', password_confirmation: 'zinza123@'

10.times do
  user = User.new
  user.email = Faker::Internet.email
  user.password = 'zinza123@'
  user.password_confirmation = 'zinza123@'
  user.save
  3.times do
    order = Order.new
    order.user = user
    order.order_details = { Faker::Number.unique.between(1, 100) => Faker::Number.between(1, 10),
                            Faker::Number.unique.between(1, 100) => Faker::Number.between(1, 10) }
    order.save
  end
end
Rails.logger.info('End Seed')
