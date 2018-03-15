class DailyReportMailer < ApplicationMailer
  def send_daily_report(user, orders)
    @user = user
    @orders = orders
    mail(to: @user.email, subject: 'Thanks you for order form us')
  end
end
