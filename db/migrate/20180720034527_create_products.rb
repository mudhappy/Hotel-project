class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :recommended_price
      t.decimal :sale_price
      t.integer :quantity

      t.timestamps
    end
  end
end
