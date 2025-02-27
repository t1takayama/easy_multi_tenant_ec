class Address < ApplicationRecord
  validates :name, presence: true
  validates :prefecture, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :customer_id, presence: true
end
