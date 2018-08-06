class CreateProductsRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :products_rooms, id: false do |t|
      t.references :room, foreign_key: true
      t.references :product, foreign_key: true
    end
  end
end
