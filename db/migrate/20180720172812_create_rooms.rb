class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.references :rooms_type, foreign_key: true
      t.references :rooms_state, foreign_key: true
      t.decimal :price
      t.string :dni
      t.integer :roomer_quantities
      t.datetime :left_at

      t.timestamps
    end
  end
end
