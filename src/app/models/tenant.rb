class Tenant < ApplicationRecord
  validates :name, presence: true
  validates :domain, presence: true

  has_many :owners, dependent: :destroy

  enum :status, {
    normal: 0,
    closed: 1         
  }
end
