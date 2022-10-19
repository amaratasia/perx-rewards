class CreateUserRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :user_rewards do |t|
      t.references :user, null: false, foreign_key: true
      t.references :reward, null: false, foreign_key: true
      t.boolean :status, default: true
      t.json :meta, default: {}

      t.timestamps
    end
  end
end
