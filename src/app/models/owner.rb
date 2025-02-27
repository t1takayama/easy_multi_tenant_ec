class Owner < ApplicationRecord
  has_secure_password

  belongs_to :tenant

  validates :email, presence: true, uniqueness: true
  validates :tenant_id, presence: true
end
