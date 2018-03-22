require 'rails_helper'

describe Order, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:user_id) }

  it 'is valid order_details' do
    FactoryBot.build(:order).valid?
  end
end
