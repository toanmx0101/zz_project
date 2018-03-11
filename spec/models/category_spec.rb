require 'rails_helper'

describe Category, type: :model do
  it 'is valid with valid attributes' do
    expect(FactoryBot.build(:category)).to be_valid
  end

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_length_of(:name).is_at_most(100) }

  it { should validate_presence_of(:description) }
  it { should validate_length_of(:description).is_at_most(1000) }
end
