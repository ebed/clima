Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tests 
  resources :informacion
  root "informacion#index"
  mount ActionCable.server => '/cable'
end
