# == Schema Information
#
# Table name: orders
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  order_details :text(65535)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Order < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  serialize :order_details
  validate :order_details_is_valid

  def order_details_is_valid
    errors.add(:order_details, 'Product ID or Quantity is invalid') unless order_details.is_a?(Hash) || !order_details.keys.all? { |h| h.is_a?(Numeric) } || !order_details.values.all? { |h| h.is_a?(Numeric) }

    errors.add(:order_details, 'Product doesn\'t exists') unless order_details.keys.all? { |h| Product.exists?(h) }
  end
end
