desc 'send daily report email'
task send_daily_report_email: :environment do
  admin_user = AdminUser.first
  orders = Order.orders_in_day
  DailyReportMailer.send_daily_report(admin_user, orders).deliver_now
end
