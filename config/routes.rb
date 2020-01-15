Rails.application.routes.draw do
  resources :projects do
  	collection do
  		get :dashboard
  	end
  	member do
  		get :edit_status
  		patch :update_status
  	end
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root to: "projects#dashboard"
end
