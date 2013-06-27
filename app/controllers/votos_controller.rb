class VotosController < InheritedResources::Base
  respond_to :json

  def pode_alterar(voto, procurador, user)
    if voto.procurador_id != procurador.id and user.id != procurador.id
      # nao eh o procurador e nem o dono do voto, ou seja, nao pode alterar o voto
      return false
    else
      return true 
    end
  end

  def votar(user, projeto, procurador)
    voto = Voto.find_by_user_id_and_projeto_id(user.id, projeto.id)
    if voto
      # o voto existe, verificamos se ele pode alterar o voto
      if !pode_alterar(voto, procurador, user)
        return voto
      end
    else
      voto = Voto.new()
    end
    voto.user = user
    voto.valor = params[:valor]
    voto.projeto = projeto
    voto.procurador_id = procurador.id
    voto.save()
    return voto
  end

  def create
  	user = find_or_create_user_by_facebookid(params[:user])
  	projeto = Projeto.find(params[:projeto][:id])
  	@voto = votar(user, projeto, user)
    user.descendants().each do |u|
      votar(u, projeto, user)
    end

  	respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @voto}
      format.json { render :json => @voto.to_json(:methods => :resumo) }
    end
  end
end