class SubdomainPresent
  def self.matches?(request)
    if Rails.env == "production"
	    request.subdomain.present?
    elsif Rails.env == "staging"
      request.subdomain.present?
    else
      request.subdomain.gsub!(".gst-alokrawat050","").present?
	  end
  end
end

class SubdomainBlank
  def self.matches?(request)
    if Rails.env == "production"
	    request.subdomain.blank?
    elsif Rails.env == "staging"
      request.subdomain.blank?
    else
      request.subdomain.gsub!(".gst-alokrawat050","").blank?
	  end
  end
end

Rails.application.routes.draw do
  get 'plans/index'
  constraints(SubdomainPresent) do 
    root 'home#index', as: :subdomain_root
    #devise_for :users
    devise_for :users,
    controllers: { invitations: 'users/invitations' }
    resources :invite_users
    resources :users#, only: :index
    resources :payments, only: [:new, :create]
    resources :plans, only: [:index]
    resources :company_masters
  end  
  
  constraints(SubdomainBlank) do 
    root 'welcome#index'
    resources :accounts, only: [:new, :create]
    resources :welcome do
      collection { post :find_team }
    end
  end  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
