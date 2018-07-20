class AddUserToEnterprise < ActiveRecord::Migration[5.1]
  def change
    add_reference :enterprises, :user, foreign_key: true
  end
end
