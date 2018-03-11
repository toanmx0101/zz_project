require 'rails_helper'
require 'devise'
describe User, type: :model do

  context 'valid Factory' do
    it 'has a valid factory' do
      expect(build(:user)).to be_valid
    end
  end

  context 'validations' do
    before { create(:user) }

    context 'presence' do
      it { should validate_presence_of :email }
      it { should validate_presence_of :password }
    end

    context 'uniqueness' do
      it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    end

    context 'length' do
       it { should validate_length_of(:email).is_at_most(255) }
       it { should validate_length_of(:password).is_at_least(Devise.password_length.begin).is_at_most(Devise.password_length.end) }
    end
  end
end