class AddDefaultAdminToUsers < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :admin, from: nil, to: false
  end
end
