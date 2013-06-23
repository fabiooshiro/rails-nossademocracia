class AddEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :facebookid, :string
  end
end
