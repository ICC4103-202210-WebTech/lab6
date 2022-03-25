class AddOrderRefToTicket < ActiveRecord::Migration[7.0]
  def change
    add_reference :tickets, :order, null: false, foreign_key: true
  end
end
