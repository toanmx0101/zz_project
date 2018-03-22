# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  avatar                 :string(255)
#

class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :orders, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :order_details, through: :orders
  has_many :bought_products, through: :order_details, source: 'product'
  has_many :bought_from, through: :bought_products, source: 'user'

  # Mua san pham tu ai
  has_many :sold_order_details, through: :products, source: 'order_details'
  has_many :sold_orders, through: :sold_order_details, source: 'order'
  has_many :buyers, through: :sold_orders, source: 'user'

  validates_associated :orders
  validates_associated :products
  validates :email, presence: true, length: { maximum: 255 }, format: { with: Devise.email_regexp }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { within: Devise.password_length }, allow_nil: true

  validates_processing_of :avatar

  scope :sold_for, ->(user) { where(id: Product.where(id: user.order_details.map(&:product_id)).map(&:user_id)) }
end
