require 'rails_helper'

describe Category, type: :model do
  it 'is valid with valid attributes' do
    expect(FactoryBot.build(:category)).to be_valid
  end

  it 'is not valid without a name' do
    expect(FactoryBot.build(:category, name: nil)).to_not be_valid
  end

  it 'is category name uniqueness' do
    expect(FactoryBot.build(:category, name: 'example')).to_not be_valid
  end

  it 'is not valid without a description' do
    expect(FactoryBot.build(:category, description: nil)).to_not be_valid
  end
end
