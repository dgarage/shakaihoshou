Blog::Application.routes.draw do
  get '/article' => 'article#index'
  get '/article/:title' => 'article#title'
  get '/ranking' => 'home#ranking'
  get '/top_search' => 'home#top_search'
  get '/header_search' => 'home#header_search'
  get '/search_by_area' => 'home#search_by_area'
  get '/comparison_by_area' => 'home#comparison_by_area'
  get '/show_details' => 'home#show_details'
  get '/detailed_search' => 'home#detailed_search'
  get 'search_by_scene' => 'home#search_by_scene'
  get 'search_by_scene_step2' => 'home#search_by_scene_step2'
  get 'search_by_scene_step3' => 'home#search_by_scene_step3'
  get '/page_not_found' => 'home#page_not_found'
  get '/sitemap.xml' => 'sitemap#index'
  root :to => 'home#index'

 
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
