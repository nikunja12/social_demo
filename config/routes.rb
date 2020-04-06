Rails.application.routes.draw do
  get 'posts/index'
  
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}
  root to: "home#index"
  resources :posts do
  	resources :comments
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
