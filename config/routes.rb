Rails.application.routes.draw do
  resources :games, only: [:new, :create, :show]
  root "games#new"
  get "player/click", to: "games#click", as: 'click' 
end
