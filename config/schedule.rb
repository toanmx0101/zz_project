set :environment, 'development' 

every '* * * * *' do
  rake "send_daily_report_email"
end
