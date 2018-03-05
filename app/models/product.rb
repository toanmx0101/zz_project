class Product < ApplicationRecord
  belongs_to :category

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: value
  validates :description, presence: true, length: { maximum: 1000 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :category_id, presence: true
end
