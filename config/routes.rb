Rails.application.routes.draw do

	root :to => "lists#index"
	get '/:id' =>  "lists#show"
	resources :tasks
	resources :lists
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
