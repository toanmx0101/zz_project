ActiveAdmin.register User do
  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end
  show do
    panel 'Order History' do
      table_for(user.orders) do
        column('Order', sortable: :id) do |order|
          link_to "##{order.id}", admin_order_path(order)
        end
        column('Date', sortable: :created_at) do |order|
          pretty_format(order.created_at.strftime('%B %e, %Y %H:%I'))
        end
        column('total_price') { |order| order.total_price.round(2) }
      end
    end
    panel 'Basic Information' do
      table_for(user) do
        column :email
      end
    end
  end
  sidebar 'Order History', only: :show do
    attributes_table_for user do
      row('Total Orders') { user.orders.count }
      row('Total Value') { user.orders.sum(:total_price) }
    end
  end
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
end
