class Order < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  serialize :order_details
  validate :order_details_is_valid

  def order_details_is_valid
    return unless order_details.is_a?(Hash) || order_details.keys.all? { |h| h.is_a?(Numeric) } || order_details.values.all? { |h| h.is_a?(Numeric) }
    errors.add(:order_details, 'Product ID or Quantity is invalid')

    return unless order_details.keys.all? { |h| Product.exists?(h) }
    errors.add(:order_details, 'Product doesn\'t exists')
  end
end
