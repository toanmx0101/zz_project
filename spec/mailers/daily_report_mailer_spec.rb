require 'rails_helper'

RSpec.describe DailyReportMailer, type: :mailer do
  describe 'DailyReportMailer' do
    context 'headers' do
      it 'renders the subject' do
        user = FactoryBot.create(:admin_user)
        mail = DailyReportMailer.send_daily_report(user, Order.orders_in_day)
        expect(mail.subject).to eq I18n.t('mail.daily_report.header')
      end

      it 'sends to the right email' do
        user = FactoryBot.create(:admin_user)
        mail = DailyReportMailer.send_daily_report(user, Order.orders_in_day)
        expect(mail.to).to eq [user.email]
      end

      it 'renders the from email' do
        user = FactoryBot.create(:admin_user)
        mail = DailyReportMailer.send_daily_report(user, Order.orders_in_day)
        expect(mail.from).to eq ['from@example.com']
      end
    end
  end
end
