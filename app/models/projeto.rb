class Projeto < ActiveRecord::Base
  attr_accessible :titulo, :conteudo
  belongs_to :user
end
