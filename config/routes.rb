PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources :posts, except: :destroy do
    resources :comments, only: [:index, :create]
  end
  resources :categories, only: [:new, :create]
end
