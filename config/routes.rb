Rails.application.routes.draw do
  root 'pages#index'
  get '/pages' => 'pages#index'
  get '/add', :to => 'pages#new'
  get '/*slug/add', :to => 'pages#new', :as => :new_nested_pages
  get '/*slug/edit', :to => 'pages#edit', :as => :edit_nested_pages
  get '/*slug', :to => 'pages#show', :as => :nested_pages
  patch '/*slug', :to => 'pages#update'
  put '/*slug', :to => 'pages#update'
  delete '/*slug', :to => 'pages#destroy'
  resources :pages, path: "", path_names: { new: 'add' }, except: [:update]
end
