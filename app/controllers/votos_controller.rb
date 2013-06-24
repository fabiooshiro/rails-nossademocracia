class VotosController < InheritedResources::Base
  respond_to :json

  def create
  	user = find_or_create_user_by_facebookid(params[:user])
  	projeto = Projeto.find(params[:projeto][:id])
  	@voto = Voto.find_by_user_id_and_projeto_id(user.id, projeto.id)
  	unless @voto
  		@voto = Voto.new()
  	end
  	@voto.user = user
  	@voto.valor = params[:valor]
  	@voto.projeto = projeto
  	@voto.procurador_id = user.id
  	@voto.save()
  	respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @voto}
      format.json { render :json => @voto.to_json(:methods => :resumo) }
    end
  end
end