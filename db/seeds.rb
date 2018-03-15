Rails.logger.info('Start Seed')
Rails.logger.info('Category and Product Seed')
# Delete all the things!
AdminUser.delete_all
Order.delete_all
User.delete_all
Product.delete_all

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
    product.image = Faker::Avatar.image('my-own-slug', '50x50')
    product.save
  end
end
Rails.logger.info('End Seed')

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
    product_1 = Product.all.map(&:id).sample
    product_2 = Product.all.map(&:id).sample
    qty_1 = Faker::Number.between(1, 10)
    qty_2 = Faker::Number.between(1, 10)
    order.order_details = { product_1 => qty_1,
                            product_2 => qty_2 }
    order.total_price = (Product.find(product_1).price * qty_1) + (Product.find(product_2).price * qty_2)
    order.save
  end
end
Rails.logger.info('End Seed')
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
