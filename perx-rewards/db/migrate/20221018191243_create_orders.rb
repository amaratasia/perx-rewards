class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :amount_su, default: 0
      t.json :meta, default: {}

      t.timestamps
    end
  end
end
