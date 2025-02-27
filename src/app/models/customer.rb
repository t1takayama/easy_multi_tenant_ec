class Customer < ApplicationRecord
  has_secure_password

  belongs_to :tenant

  has_many :cart_items
  has_one :address

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :status, presence: true
  validates :tenant_id, presence: true

  enum :status, {
    normal: 0,
    withdrawn: 1,
    banned: 2
  }
end
