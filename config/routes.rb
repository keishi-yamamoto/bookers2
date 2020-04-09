Rails.application.routes.draw do
	root 'home#index'
	devise_for :users

	resources :post_books, only: [:new, :create, :index, :show]
end
