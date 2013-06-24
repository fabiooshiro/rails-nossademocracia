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

  def show
    @projeto = Projeto.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projeto}
      format.json { render :json => @projeto.to_json(:methods => :resumo)}
    end
  end

  def create
    user = find_or_create_user_by_facebookid(params[:user])
    
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
