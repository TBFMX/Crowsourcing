Rails.application.routes.draw do
  get 'home/index', as: 'home'

  get 'home/about'

  get 'home/contact'

  get 'home/projects'

  resources :users

  resources :comments

  resources :amends

  resources :funders

  resources :videos

  resources :galleries

  resources :images

  resources :perks

  resources :projects


  resources :rols

  resources :password_resets

  controller :users do
    get 'recover_password' => :recover_password
    post 'recover_password' => :recover_password 
    get 'new_recover_password' => :new_recover_password
    post 'new_recover_password' => :new_recover_password 
    get 'cambiar_password' => :cambiar_password
    post 'cambiar_password' => :cambiar_password
    get 'new_cambiar_password' => :new_cambiar_password
    post 'new_cambiar_password' => :new_cambiar_password
  end 
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  post 'projects/uploadFile', as: 'uploadFile'

  controller :perks do
    get 'pagos/paypal/:id' => :paypal
    post 'pagos/paypal' => :paypal
    get 'pagar/:id' => :prosses_pay
    get 'pago/paypal/exito' => :pago_paypal
  end

  #preparacion para usar rutas amigables o traducidas segun se ocupe

  controller :galleries do
    get 'projects/galleries/:id' => :index
    get 'galleries/new/:id' => :new
    post 'galleries/new/:id' => :new
    get 'galleries/:id/edit/:proy' => :new
    post 'galleries/:id/edit/:proy' => :new
  end  
  controller :amends do
    get 'projects/amends/:id' => :index
    get 'amends/new/:id' => :new
    post 'amends/new/:id' => :new
    get 'amends/:id/edit/:proy' => :new
    post 'amends/:id/edit/:proy' => :new
  end  
  controller :videos do
    get 'galleries/videos/:id' => :index
    get 'videos/new/:id' => :new
    post 'videos/new/:id' => :new
    get 'videos/:id/edit/:proy' => :new
    post 'videos/:id/edit/:proy' => :new
  end  
  controller :images do
    get 'galleries/images/:id' => :index
    get 'images/new/:id' => :new
    post 'images/new/:id' => :new
    get 'images/:id/edit/:proy' => :edit
    post 'images/:id/edit/:proy' => :edit
  end
  controller :comments do
    get 'projects/comments/:id' => :index    
    get 'comments/new/:id' => :new
    post 'comments/new/:id' => :new
    get 'comments/:id/edit/:proy' => :edit
    post 'comments/:id/edit/:proy' => :edit
  end   
  controller :perks do
    get 'projects/perks/:id' => :index
    get 'perks/new/:id' => :new
    post 'perks/new/:id' => :new
    get 'perks/:id/edit/:proy' => :edit
    post 'perks/:id/edit/:proy' => :edit
  end
  controller :funders do
    get 'projects/funders/:id' => :index
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'home#index'

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
