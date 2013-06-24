class Projeto < ActiveRecord::Base
  attr_accessible :titulo, :conteudo
  belongs_to :user
  
  def resumo
  	Voto.where("projeto_id = ?", id).select("valor, count(*) as total").group("valor")
  end
end
