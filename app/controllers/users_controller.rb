class UsersController < InheritedResources::Base
	respond_to :json

	def show
		@user = User.find_by_facebookid(params[:id])
		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @user}
			format.json { render :json => @user.to_json(:methods => :representante)}
		end
	end

	def update
		logger.debug "atualizando user..."
		parent = User.find(params[:parent_id])
		@user = find_or_create_user_by_facebookid(params)
		@user.parent_id = parent.id
		@user.move_to_child_of(parent)
		@user.save()
		logger.debug "usuario atualizado"
		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @user}
			format.json { render :json => @user.to_json(:include => :representante)}
		end
	end

	def destroy
		logger.debug "entrou nao sai :-)"
	end

end
