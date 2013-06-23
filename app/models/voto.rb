class Voto < ActiveRecord::Base
  belongs_to :projeto
  belongs_to :user
end
