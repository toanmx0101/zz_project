class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: value
  validates :description, presence: true, length: { maximum: 1000 }
end
