class AddCurrencyToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :currency, :string, default: 'INR'
  end
end
