PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources :posts, except: :destroy do
    member do
      post 'vote'
    end

    resources :comments, only: :create do
      member do
        post 'vote'
      end
    end
  end

  resources :categories, only: [:new, :create, :show]

  get 'login', to: 'sessions#new'
  get 'register', to: 'users#new'
  resources :users, except: [:destroy, :index, :new]

  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
end
