FactoryBot.define do
  factory :address do
    name { Faker::Name.name }
    prefecture { Faker::Address.city }
    postal_code { Faker::Address.postcode }
    address { Faker::Address.full_address }
    customer_id {}
  end
end
