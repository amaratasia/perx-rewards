class CreateUserPoints < ActiveRecord::Migration[6.1]
  def change
    create_table :user_points do |t|
      t.references :order, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :points, default: 0
      t.json :meta, default: {}
      t.integer :running_balance, default: 0

      t.timestamps
    end
  end
end
