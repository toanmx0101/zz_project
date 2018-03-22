class RemoveOrderDetailsFromOrder < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :order_details, :boolean
  end
end
