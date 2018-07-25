class AddEnterpriseToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :enterprise, foreign_key: true
  end
end
