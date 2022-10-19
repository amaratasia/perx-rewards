class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.integer :points, default: 0
      t.datetime :dob
      t.string :email

      t.timestamps
    end
  end
end
