class AddEnterpriseToRoomsType < ActiveRecord::Migration[5.1]
  def change
    add_reference :rooms_types, :enterprise, foreign_key: true
  end
end
