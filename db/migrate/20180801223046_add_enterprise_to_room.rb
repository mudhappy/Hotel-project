class AddEnterpriseToRoom < ActiveRecord::Migration[5.1]
  def change
    add_reference :rooms, :enterprise, foreign_key: true
  end
end
