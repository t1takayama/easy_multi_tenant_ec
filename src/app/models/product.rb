class Product < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :tenant_id, presence: true
  validates :image, presence: true

  has_one_attached :image
end
