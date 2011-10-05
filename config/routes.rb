AsKuery::Application.routes.draw do

  get "system/index"

  resources :votes
  resources :posts
  resources :users
  resources :sessions, :only => [:new, :create, :destroy]

  match '/askuery' => 'system#index'
  match '/system' => 'system#index'
  match '/signin' => 'sessions#new'
  match '/signout' => 'sessions#destroy'
  match '/sessions/:id' => 'sessions#destroy'
  match '/profile' => 'users#show'
  match '/system/add_new_post' => 'system#add_new_post'
  match '/system/add_new_reply' => 'system#add_new_reply'
  match '/system/add_new_vote' => 'system#add_new_vote'
  match '/system/grant_admin' => 'system#grant_admin'
  match '/system/revoke_admin' => 'system#revoke_admin'
  match '/posts/:id' => 'posts#destroy'
  match '/system/delete_user' => 'system#delete_user'
  match '/system/search_results' => 'system#search_results'
  match '/system/see_all_questions' => 'system#see_all_questions'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'system#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
