class UserNestedSet < ActiveRecord::Migration
  def change
  	add_column :users, :parent_id, :integer
  	add_column :users, :lft, :integer
  	add_column :users, :rgt, :integer
  	add_column :users, :cpf, :string
  end
end
