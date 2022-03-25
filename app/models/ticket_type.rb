class TicketType < ApplicationRecord
  belongs_to :event
  has_many :tickets
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
