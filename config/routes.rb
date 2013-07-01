SimpleForum::Application.routes.draw do
  resources :authentications

  resources :forums, :defaults => {format: :json} do
    resources :comments, :defaults => {format: :json}
  end
  resources :projetos, :defaults => {format: :json}
  resources :votos, :defaults => {format: :json}
  
  # colado do https://github.com/CanCeylan/moltoSoldi/blob/master/config/routes.rb
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
    controllers: {omniauth_callbacks: "authentications", registrations: "registrations"}

  
  devise_scope :user do
    get "/users/logout", :to => "devise/sessions#destroy"
  end

  # tem que vir depois do devise
  resources :users, :defaults => {format: :json}

#  root to: 'application#index'
	root to: 'authentications#home'
end
