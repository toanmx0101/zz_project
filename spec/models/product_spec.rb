require 'rails_helper'

describe Product, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_length_of(:name).is_at_most(100) }

  it { should validate_presence_of(:description) }
  it { should validate_length_of(:description).is_at_most(1000) }

  it { should validate_presence_of(:price) }
  it do
    should validate_numericality_of(:price).is_greater_than_or_equal_to(0)
  end
  it { should belong_to(:category) }

  it 'return list of product in category' do
    category = FactoryBot.create(:category)
    product = FactoryBot.create(:product, category_id: category.id)
    expect(Product.category(category.id)).to eq [product]
  end
end
