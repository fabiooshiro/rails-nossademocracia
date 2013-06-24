class AddUserRefToVotos < ActiveRecord::Migration
  def change
    add_column :votos, :procurador_id, :integer ,:references=>"users"
  end
end
