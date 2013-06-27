class UsersController < InheritedResources::Base
	respond_to :json

	def show
		@user = User.find_by_facebookid(params[:id])
		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @user}
			format.json { render :json => @user}
		end
	end

	def update
		logger.debug "atualizando user"
		parent = User.find(params[:parent_id])
		@user = find_or_create_user_by_facebookid(params)
		@user.parent_id = parent.id
		@user.save()
		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @user}
			format.json { render :json => @user}
		end
	end
end
