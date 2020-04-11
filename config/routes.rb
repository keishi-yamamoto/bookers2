Rails.application.routes.draw do
	root 'home#index'
	devise_for :users

	resources :books
	resources :users, only: [:show, :index, :edit, :update]
end