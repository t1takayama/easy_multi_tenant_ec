FactoryBot.define do
  factory :order do
    name { Faker::Name.name }
    prefecture { Faker::Address.city }
    postal_code { Faker::Address.postcode }
    address { Faker::Address.full_address }
    payment_method { "bank" }
    postage { 500 }
    billing_amount { rand(1000..10000) }
    customer_id {}
  end
end
