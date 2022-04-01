class AddAgeToCustomer < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :age, :integer
  end
end
