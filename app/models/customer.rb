class Customer < ApplicationRecord
  has_many :orders
  has_many :tickets, through: :orders
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
