Rails.application.routes.draw do  
  get 'users/index'
  devise_for :users 
  root 'users#index'  
  get 'chat_users/create'
  get 'chats/show' 
  mount ActionCable.server => "/cable"

  get "up" => "rails/health#show", as: :rails_health_check 

  resources :users, only: [:index]  
  
  resources :chats do
    resources :messages, only: [:create]
  end 
  
end

