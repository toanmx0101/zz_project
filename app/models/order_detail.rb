class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :order, presence: true
  validates :product, presence: true
  validates :qty, presence: true, numericality: { greater_than: 0 }

  scope :who_purchased_products, ->(products) { joins(:product).where(product_id: products).includes(:order).includes(:product) }
end
