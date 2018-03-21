ActiveAdmin.register Order do
  actions :index, :show

  index do
    selectable_column
    column('Order', sortable: :id) { |order| link_to "##{order.id}", admin_order_path(order) }
    column('User', :user, sortable: :user_id)
    column('Date', :created_at)
  end

  show do
    panel 'Invoice' do
      order_details = order.order_details.includes(:product)      
      table_for(order_details) do |t|
        t.column('Product') { |item| auto_link item.product }
        t.column('Quantity') { |item| item.qty }
        t.column('Price') { |item| number_to_currency item.product.price }
        tr class: 'odd' do
          td
          td 'Total:', style: 'text-align: right;'
          td number_to_currency(order.total_price)
        end
      end
    end
  end

  sidebar :customer_information, only: :show do
    attributes_table_for order.user do
      row('User') { auto_link order.user }
    end
  end

  filter :user
  filter :created_at
end
