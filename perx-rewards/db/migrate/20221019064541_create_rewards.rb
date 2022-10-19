class CreateRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :rewards do |t|
      t.string :name, null: false
      t.string :format, null: false
      t.json :config, default: {}

      t.timestamps
    end
  end
end
