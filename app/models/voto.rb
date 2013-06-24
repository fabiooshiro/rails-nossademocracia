class Voto < ActiveRecord::Base
  belongs_to :projeto
  belongs_to :user
  has_one :procurador, :foreign_key => "procurador_id", :class_name => "User"

  def resumo
  	Voto.where("projeto_id = ?", projeto.id).select("valor, count(*) as total").group("valor")
  end
end
