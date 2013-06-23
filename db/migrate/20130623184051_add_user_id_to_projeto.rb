class AddUserIdToProjeto < ActiveRecord::Migration
  def change
    add_column :projetos, :user_id, :integer
  end
end
