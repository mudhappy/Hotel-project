class CreateLocals < ActiveRecord::Migration[5.1]
  def change
    create_table :locals do |t|
      t.references :enterprise, foreign_key: true
      t.integer :stars
      t.string :address

      t.timestamps
    end
  end
end
