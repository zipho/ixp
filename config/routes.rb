Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  get 'users/new' => 'users#new', :as => :start
  post 'users' => 'users#create', :as => :register
  get 'users' => 'users#new'
  get 'users/:id' => 'users#edit', :as => :next
  get 'users/:id' => 'users#show', :as => :done
  root to: "users#new"
end
