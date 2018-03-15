class DailyReportJob < ApplicationJob
  queue_as :default

  def perform(admin_user_id)
    admin_user = AdminUser.find_by(admin_user_id)
    orders = Order.orders_in_day
    DailyReportMailer.send_daily_report(admin_user, orders).deliver_later(wait_until: 24.hours.from_now) if admin_user
  end
end
