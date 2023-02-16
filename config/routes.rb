Rails.application.routes.draw do
  root 'articles#index'
  get 'about', to: 'pages#about'
  resources :articles
end
