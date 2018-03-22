require 'csv'
desc 'Export orders'
task export_orders: :environment do
  CSV.open('order.csv', 'w')
end
