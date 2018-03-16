set :environment, 'development' 

every '0 18 */1 * *' do
  rake "send_daily_report_email"
end
