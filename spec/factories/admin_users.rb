require 'faker'

FactoryBot.define do
  factory :admin_user do |f|
    f.email { Faker::Internet.email }
    f.password { 'zinza123@' }
    f.password_confirmation { 'zinza123@' }
  end
end
