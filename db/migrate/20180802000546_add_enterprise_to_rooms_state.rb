class AddEnterpriseToRoomsState < ActiveRecord::Migration[5.1]
  def change
    add_reference :rooms_states, :enterprise, foreign_key: true
  end
end
