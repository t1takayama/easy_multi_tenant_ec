class Order < ApplicationRecord
  validates :name, presence: true
  validates :prefecture, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :postage, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :billing_amount, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :payment_method, presence: true
  validates :customer_id, presence: true

  has_many :order_details, dependent: :destroy
  belongs_to :customer

  enum :status, {
    waiting_payment: 0,
    confirm_payment: 1,
    shipped: 2,
    out_of_delivery: 3,
    delivered: 4
  }

  enum :payment_method, {
    bank: 0,
    convenience: 1,
    credit_card: 2   
  }
end
