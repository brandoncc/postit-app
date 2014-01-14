PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  concern :voteable do
    get 'vote'
  end

  resources :posts, except: :destroy do
    concerns :voteable
    resources :comments, only: :create
  end

  get 'comments/:comment_id/vote', to: 'comments#vote', as: 'comment_vote'

  resources :categories, only: [:new, :create, :show]

  resources :users, except: [:destroy, :index]

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
