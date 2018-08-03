class AddEnterpriseToProducts < ActiveRecord::Migration[5.1]
  def change
    add_reference :products, :enterprise, foreign_key: true
  end
end
