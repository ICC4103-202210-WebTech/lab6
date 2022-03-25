class Ticket < ApplicationRecord
  belongs_to :ticket_type
  belongs_to :order

  after_save :increment_order_total
  after_destroy :decrement_order_total

  private
  
  def increment_order_total
    self.order.total += self.ticket_type.price
    self.order.save
  end

  def decrement_order_total
    self.order.total -= self.ticket_type.price
    self.order.save
  end
end
