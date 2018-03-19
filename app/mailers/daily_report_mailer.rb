class DailyReportMailer < ApplicationMailer
  def send_daily_report(user, orders)
    @user = user
    @orders = orders
    mail(to: @user.email, subject: I18n.t('mail.daily_report.subject'))
  end
end
