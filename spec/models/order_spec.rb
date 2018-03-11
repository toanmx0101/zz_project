require 'rails_helper'

describe Order, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:user_id) }
  it { should serialize(:order_details) }
  it { should validate_presence_of(:order_details) }

  it 'is valid order_details' do
    FactoryBot.build(:order).valid?
  end

  it 'order_details hash' do
    order = Order.new(user_id: FactoryBot.create(:user).id, order_details: 2)
    expect(order).to_not be_valid
    order = FactoryBot.build(:order, order_details: 'Example')
    expect(order).to_not be_valid
  end

  it 'product_id is numeric in order details hash' do
    order = Order.new(user_id: FactoryBot.create(:user).id, order_details: { 'Example' => 2 })
    expect(order).to_not be_valid
  end
  it 'product quanity is numeric in order details hash' do
    order = Order.new(user_id: FactoryBot.create(:user).id, order_details: { 'Example' => 'Z' })
    expect(order).to_not be_valid
  end
  it 'order_details has product exists' do
    order = Order.new(user_id: FactoryBot.create(:user).id, order_details: { 1 => 2 })
    expect(order).to_not be_valid
  end
end
