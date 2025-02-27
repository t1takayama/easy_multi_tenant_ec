class CartItem < ApplicationRecord
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :customer_id, presence: true
  validates :product_id, presence: true

  def total_price
    product.price * quantity
  end
end
