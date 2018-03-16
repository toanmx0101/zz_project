  class DailyReportMailer < ApplicationMailer
  def send_daily_report(user, orders)
    @user = current_admin_user
    @orders = orders
    mail(to: @user.email, subject: "Zinza Daily Reports #{Time.zone.now.strftime('%B %d, %Y')}")
  end
end
