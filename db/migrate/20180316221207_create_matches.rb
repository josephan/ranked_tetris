class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.references :player_one, index: true, foreign_key: { to_table: :users }
      t.references :player_two, index: true, foreign_key: { to_table: :users }
      t.references :winner, index: true, foreign_key: { to_table: :users }
      t.datetime :start_date

      t.timestamps
    end
  end
end
