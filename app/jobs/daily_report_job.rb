class DailyReportJob < ApplicationJob
  queue_as :default

  def perform(admin_user, order)
    DailyReportMailer.send_daily_report(admin_user, order).deliver_now
  end
end
