FactoryBot.define do
  factory :cart_item do
    quantity { rand(10..1000) }
    customer_id {}
    product_id {}
  end
end
