class CreateProjetos < ActiveRecord::Migration
  def change
    create_table :projetos do |t|
      t.string :titulo
      t.text :conteudo

      t.timestamps
    end
  end
end
