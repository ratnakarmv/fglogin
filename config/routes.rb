Rails.application.routes.draw do



  get 'management', to: redirect('management/subscription')
  get 'management/subscription'

  post 'management/subscription', to: 'management#update_meal', as: 'management_update_meal'

  get 'management/edit_subscription/:id', to: 'management#edit_subscription', as: "management_edit_subscription"
  patch 'management/edit_subscription/:id', to: 'management#update_subscription'

  get 'management_edit_customer/:id', to: 'management#edit_customer', as: 'management_edit_customer'
  patch 'management_edit_customer/:id', to: 'management#update_customer'

  post 'general/payment', to: 'general#payment', as: 'payment'

  get 'general/subscription'

  get 'general/home'

  devise_for :customers, controllers: { sessions: "customers/sessions", registrations: 'customers/registrations' }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'customers#show'

  resources :addresses, only: [:new, :edit, :update]

  resources :subscriptions, only: [:create, :edit, :update, :new]

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
