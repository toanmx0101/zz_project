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
  has_many :order_details
  validates :user_id, presence: true
  validates :total_price, presence: true

  scope :orders_in_day, ->(date = Time.zone.now) { where(created_at: date.beginning_of_day..date.end_of_day) }
  # def order_details_is_valid
  #   if !order_details.is_a?(Hash)
  #     errors.add(:order_details, 'Order details is invalid')
  #   elsif !order_details.keys.all? { |h| h.is_a?(Numeric) } || !order_details.values.all? { |h| h.is_a?(Numeric) }
  #     errors.add(:order_details, 'Product ID or Quantity is invalid')
  #   elsif !order_details.keys.all? { |h| Product.exists?(h) }
  #     errors.add(:order_details, 'Product doesn\'t exists')
  #   end
  # end
end
