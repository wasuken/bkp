Rails.application.routes.draw do
  root to: 'journals#index'
  get 'journals/new'
  get 'journals/index'
  get 'journals/show'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
