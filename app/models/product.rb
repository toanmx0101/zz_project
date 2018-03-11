# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  category_id :integer
#  description :string(255)
#  price       :float(24)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ApplicationRecord
  belongs_to :category

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: true
  validates :description, presence: true, length: { maximum: 1000 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :category_id, presence: true

  scope :category, ->(category) { where(category_id: category) }
  scope :search_like, ->(q) { where('name LIKE ?', q) }
  scope :order_by, ->(order_culumn, order_type) { reorder(order_culumn + ' ' + order_type) }
  paginates_per 10
end
