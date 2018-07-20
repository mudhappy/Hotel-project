class CreateRoomsTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms_types do |t|
      t.string :name
      t.integer :bed_cuantities
      t.decimal :recommended_price

      t.timestamps
    end
  end
end
