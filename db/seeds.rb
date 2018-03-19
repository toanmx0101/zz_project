
Rails.logger.info('Start Seed')
Rails.logger.info('Category and Product Seed')
# Delete all the things!
AdminUser.delete_all
Order.delete_all
User.delete_all
Product.delete_all
10.times do
  user = User.new
  user.email = Faker::Internet.email
  user.password = 'zinza123@'
  user.password_confirmation = 'zinza123@'
  user.save
end

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
    product.user = User.all.sample
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
    first_product = Product.all.map(&:id).sample
    second_product = Product.all.map(&:id).sample
    first_qty = Faker::Number.between(1, 10)
    second_qty = Faker::Number.between(1, 10)
    order.order_details = { first_product => first_qty,
                            second_product => second_qty }
    order.total_price = (Product.find(first_product).price * first_qty) + (Product.find(second_product).price * second_qty)
    order.save
  end
end
Rails.logger.info('End Seed')
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
