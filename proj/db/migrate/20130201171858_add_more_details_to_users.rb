class AddMoreDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :description, :text
    add_column :users, :address, :text
  end
end
