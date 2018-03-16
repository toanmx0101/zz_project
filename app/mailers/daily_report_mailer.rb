class DailyReportMailer < ApplicationMailer
  def send_daily_report(user, orders)
    @user = user
    @orders = orders
    mail(to: @user.email, subject: "Zinza Daily Reports")
  end
end
