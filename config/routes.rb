Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get    '/about',   to: 'static_pages#about'
  resources :team
  resources :season
  resources :league
  
  
  resources :magazines do
    resources :ads
  end
  
end
