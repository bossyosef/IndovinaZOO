class AddFullnameToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :fullname, :string
  end
end
