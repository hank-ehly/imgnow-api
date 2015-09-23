# == Route Map
#
#                   Prefix Verb   URI Pattern                    Controller#Action
#         new_user_session GET    /users/sign_in(.:format)       api/sessions#new
#             user_session POST   /users/sign_in(.:format)       api/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)      api/sessions#destroy
#            user_password POST   /users/password(.:format)      devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)  devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format) devise/passwords#edit
#                          PATCH  /users/password(.:format)      devise/passwords#update
#                          PUT    /users/password(.:format)      devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)        api/registrations#cancel
#        user_registration POST   /users(.:format)               api/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)       api/registrations#new
#   edit_user_registration GET    /users/edit(.:format)          api/registrations#edit
#                          PATCH  /users(.:format)               api/registrations#update
#                          PUT    /users(.:format)               api/registrations#update
#                          DELETE /users(.:format)               api/registrations#destroy
#        api_images_upload POST   /api/images/upload(.:format)   api/images#upload
#                 api_test GET    /api/test(.:format)            application#test
#

Rails.application.routes.draw do

  # namespace :api do
    devise_for :users, :controllers => {:sessions => 'api/sessions', :registrations => 'api/registrations'}
  # end

  post 'api/images/upload' => 'api/images#upload'
  get 'api/test'  => 'application#test'  

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
