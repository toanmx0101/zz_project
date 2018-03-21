require 'csv'
desc 'Export orders'
task export_orders: :environment do
  CSV.open("order.csv","w") do |csv|
    Order.all.each do |order|
      csv << {order_id: order.id, user_id: order.user_id, order_details: order.order_details, created_at: order.created_at.to_f, updated_at: order.updated_at.to_f, total_price: order.total_price}
    end
  end
end
