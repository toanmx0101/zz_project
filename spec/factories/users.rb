require 'faker'

FactoryBot.define do
  factory :user do |f|
    f.email { Faker::Internet.email }
    f.password { 'zinza123@' }
    f.password_confirmation { 'zinza123@' }
    f.confirmed_at { Time.zone.now }
  end
end
