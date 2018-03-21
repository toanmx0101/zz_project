class OrderNotifier < ApplicationMailer
  default from: 'from@example.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_order_notifier(user, order, products)
    @user = user
    @order = order
    @order_details = @order.order_details
    @products = products
    mail(to: @user.email, subject: 'Thanks you for order form us')
  end
end
