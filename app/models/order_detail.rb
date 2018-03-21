class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :order, presence: true
  validates :product, presence: true
  validates :qty, presence: true, numericality: { greater_than: 0 }
end