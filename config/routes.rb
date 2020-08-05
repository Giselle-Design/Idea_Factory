Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   get "/", to: "welcome#root", as: "root"

   resources :ideas do
     resources :likes, shallow: true, only: [:create, :destroy]
     resources :reviews, only: [:create, :destroy]
   end

   resources :users, only: [:new, :create]
   resource :session, only: [:new, :create, :destroy]
end
