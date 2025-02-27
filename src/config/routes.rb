Rails.application.routes.draw do
  root 'customer/products#index'

  get 'owner', to: redirect('owner/orders')
  get 'admin', to: redirect('admin/tenants')
  
  scope module: :customer do
    resources :products, only: [:show]
    resources :cart_items, only: [:index, :create, :destroy]
    resources :addresses, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :orders, only: [:index, :new, :show, :create, :destroy] do
      collection do
        get 'success'
        get 'error'
      end
    end
    
    get  'sign_up' => 'registrations#new'
    post 'sign_up' => 'registrations#create'

    get    'sign_in'  => 'sessions#new'
    post   'sign_in'  => 'sessions#create'
    delete 'sign_out' => 'sessions#destroy'
  end

  namespace :owner do
    constraints host: ENV['OWNER_HOST'] do
      resources :products
      resources :orders, only: [:index, :show, :edit, :update]

      get    'sign_in'  => 'sessions#new'
      post   'sign_in'  => 'sessions#create'
      delete 'sign_out' => 'sessions#destroy'
    end
  end

  namespace :admin do
    constraints host: ENV['ADMIN_HOST'] do
      get    'sign_in'  => 'sessions#new'
      post   'sign_in'  => 'sessions#create'
      delete 'sign_out' => 'sessions#destroy'

      resources :tenants do
        resources :owners
      end
    end
  end
end
