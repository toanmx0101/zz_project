class DailyReportJob < ApplicationJob
  queue_as :default

  def perform(admin_user_id)
    admin_user = AdminUser.find(admin_user_id)
    orders = Order.orders_in_day
    DailyReportMailer.send_daily_report(admin_user, orders).deliver_now if admin_user
  end
end
