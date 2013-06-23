class ProjetosController < InheritedResources::Base
  respond_to :json

  def index
    @projetos = Projeto.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projetos}
      format.json { render :json => @projetos.to_json(
        :include => {
          :user => {
            :only => :name
          }
        }
      )}
    end
  end

  def create
    user = User.where("facebookid = ?", params[:user][:id]).first
    unless user
      user = User.new()
      user.name = params[:user][:name]
      user.facebookid = params[:user][:id]
      user.save()
    end
    
  	@projeto = Projeto.new()
  	@projeto.titulo = params[:titulo]
  	@projeto.conteudo = params[:conteudo]
    @projeto.user = user
  	@projeto.save()

  	respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projeto}
      format.json { render :json => @projeto}
    end
  end

end
