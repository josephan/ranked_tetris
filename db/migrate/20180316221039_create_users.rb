class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, null: false, default: ""
      t.integer :elo, null: false, default: 2000
      t.boolean :retired, null: false, default: false

      t.timestamps
    end
  end
end
