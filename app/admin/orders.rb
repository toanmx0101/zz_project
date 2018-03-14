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
      products = Product.where(id: order.order_details.keys)
      total_price = 0
      products.each do |p|
        total_price += p.price * order.order_details[p.id]
      end
      table_for(products) do |t|
        t.column('Product') { |item| auto_link item }
        t.column('Quantity') { |item| order.order_details[item.id] }
        t.column('Price') { |item| number_to_currency item.price }
        tr class: 'odd' do
          td
          td 'Total:', style: 'text-align: right;'
          td number_to_currency(total_price)
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
