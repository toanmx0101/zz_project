require 'csv'
desc 'Import from old orders'
task import_old_orders: :environment do
  csv_text = File.read('order.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    order = Order.create!(id: row.order_id, user_id: row.user_id, created_at: Time.zone.at(row.created_at).to_datetime, updated_at: Time.zone.at(row.updated_at).to_datetime)
    row.order_details.each_pair do |key, value|
      OrderDetails.create!(order_id: order.id, product_id: key, qty: value)
    end
  end
end
