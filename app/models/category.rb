# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: true
  validates :description, presence: true, length: { maximum: 1000 }
end
