class OrderDetail < ApplicationRecord
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :product_id, presence: true
  validates :order_id, presence: true

  belongs_to :product
  belongs_to :order
end
