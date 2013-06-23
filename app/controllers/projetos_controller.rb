#class ProjetosController < ApplicationController
class ProjetosController < InheritedResources::Base
  #before_action :set_projeto, only: [:show, :edit, :update, :destroy]
  respond_to :json

  # GET /projetos
  # GET /projetos.json
  def indexasd
    app_id = "384291504993293"
    secret_key = "5767620d43470694b00e0b7543709c6d"
    @oauth = Koala::Facebook::OAuth.new(app_id, secret_key)
    logger.debug cookies
    @usuario = @oauth.get_user_info_from_cookies(cookies)
    logger.debug "usuario:" << @usuario.to_s
    @projetos = Projeto.all
  end

  # GET /projetos/1
  # GET /projetos/1.json
  def showasd
  end

  # GET /projetos/new
  def newasd
    @projeto = Projeto.new
  end

  # GET /projetos/1/edit
  def editasd
  end

  # POST /projetos
  # POST /projetos.json
  def createold
    @projeto = Projeto.new(projeto_params)

    respond_to do |format|
      if @projeto.save
        format.html { redirect_to @projeto, notice: 'Projeto was successfully created.' }
        format.json { render action: 'show', status: :created, location: @projeto }
      else
        format.html { render action: 'new' }
        format.json { render json: @projeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projetos/1
  # PATCH/PUT /projetos/1.json
  def updateasd
    respond_to do |format|
      if @projeto.update(projeto_params)
        format.html { redirect_to @projeto, notice: 'Projeto was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @projeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projetos/1
  # DELETE /projetos/1.json
  def destroyasd
    @projeto.destroy
    respond_to do |format|
      format.html { redirect_to projetos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_projeto
      @projeto = Projeto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def projeto_params
      params.require(:projeto).permit(:titulo, :conteudo)
    end
end
