FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    price { rand(100..1000) }
    stock { rand(10..100) }
    tenant_id {}
  end
end
