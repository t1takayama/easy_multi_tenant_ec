FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password = Faker::Internet.password(min_length: 6)
    password { password }
    password_confirmation { password }
    tenant_id {}
  end
end
