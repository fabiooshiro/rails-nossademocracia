SimpleForum::Application.routes.draw do
  resources :forums, :defaults => {format: :json} do
    resources :comments, :defaults => {format: :json}
  end
  resources :projetos, :defaults => {format: :json}
  resources :votos, :defaults => {format: :json}
  root to: 'application#index'
end
