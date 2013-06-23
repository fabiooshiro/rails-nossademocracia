class CreateVotos < ActiveRecord::Migration
  def change
    create_table :votos do |t|
      t.string :valor
      t.references :projeto, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
