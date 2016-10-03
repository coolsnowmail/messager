Rails.application.routes.draw do
  resources :time_services
  devise_for :users
  authenticated :user do
    root to: "users#show", :as => "profile"
  end
  unauthenticated do
    root to: "senders#index", :as => "unauthenticated"
  end
  # get 'callbacks', to: 'services#callbacks'

  get "connect_vkontakteservice", to: "v_kontakte_service#connect_vkontakteservice"
  get "disconnect_vkontakteservice", to: "v_kontakte_service#disconnect_vkontakteservice"
  get "callbacks", to: "v_kontakte_service#callbacks"

  get "connect_test", to: "test#connect_test"
  get "disconnect_test", to: "test#disconnect_test"

  get 'disconnect_vk', to: 'services#disconnect_vk'
  post 'user_time_update', to: 'users#user_time_update'
  resources :senders
  resources :users do
    resources :services, only: [:show] do
      member do
      get "connect"
      get "disconnect"
    end
    end
    member do
      get "user_time_edit"
    end
  end
  get 'senders_delete', to: 'delete_senders#senders_delete'
  post 'invite_link', to: 'senders#invite_link'
  resources :messages
end
