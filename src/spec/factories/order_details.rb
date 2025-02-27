FactoryBot.define do
  factory :order_detail do
    price { rand(10..1000) }
    quantity { rand(10..100) }
    order_id {}
    product_id {}
  end
end
