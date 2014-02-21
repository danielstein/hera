Hera::Application.routes.draw do
 
  devise_for :users, controllers: {users: "users"}
  
  devise_scope :users do
    get 'users/login' => 'devise/sessions#new'
    get 'users/logout' => 'devise/sessions#destroy'
  end
  
  resources :web_services_posts
  get "web_services/web_post" => "web_services_post#web_post"

  resources :web_services_gets
  get "web_services/get_checklist" => "web_services_get#get_checklist"
  get "web_services/get_building_name" => "web_services_get#get_building_name"

  get "equipment/disapprove"
  get "equipment/validate"
  get "inspections/disapprove"
  resources :web_servicess
  get "web_services/teste_mobile" => "web_services#teste_mobile"
  get "web_services/get_building_png" => "web_services#get_building_png"
  get "web_services/get_usp_png" => "web_services#get_usp_png"
  get "web_services/get_num_pav" => "web_services#get_num_pav"
  get "web_services/get_usp_map_info" => "web_services#get_usp_map_info"
  get "web_services/get_id_by_coordinate" => "web_services#get_id_by_coordinate"
  get "web_services/get_building_info" => "web_services#get_building_info"
  get "web_services/get_gml_by_code" => "web_services#get_gml_by_code"

  
  # Desnecessario fazer dessa maneira, utilize RESTful resources
  # get "equipment/index"
  # get "equipment/show"
  resources :equipment
  #get "inspection/show"
  get "inspections/index_history"
  #get "inspection/index"
  get "inspections/validate"
  resources :inspections
  
  resources :user
  
  resources :equip_types
  
    # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'equipment#index'

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
