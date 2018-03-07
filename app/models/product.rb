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

  scope :category, -> (category) {where(category_id: category)}
  paginates_per 10
end
