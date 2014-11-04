Rails.application.routes.draw do
	root 'pages#index'
	get '/pages' => 'pages#index'
	resources :pages, path: "", path_names: { new: 'add' }
end
