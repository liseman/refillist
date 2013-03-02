class AddUserInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :screenname, :string
    add_column :users, :name, :string
    add_column :users, :timezone, :string
    add_column :users, :level, :decimal
  end
end
