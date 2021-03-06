Miniblog::Engine.routes.draw do
  root :to => 'posts#index'

  resources :posts, only: :show
  get 'sitemap.(:format)', to: 'sitemap#show'

  namespace :admin do
    resources :authors, only: :index

    match 'posts/:state', :to => 'posts#index',
      :constraints => { :state => /(published|drafted)/ },
      :as => 'posts_by_state',
      :via => :get

    match 'posts/:id/:transition', :to => 'transitions#create',
      :constraints => { :transition => /(draft|finish|review|publish)/ },
      :as => 'post_transitions',
      :via => :post

    resources :posts do
      resources :assets
      resource :state, only: :update
    end

    resources :preview, only: :show

    root :to => 'posts#index'

  end
end
