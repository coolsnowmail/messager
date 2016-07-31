Rails.application.routes.draw do
  resources :time_services
  devise_for :users
  authenticated :user do
    root to: "users#show", :as => "profile"
  end
  unauthenticated do
    root to: "senders#index", :as => "unauthenticated"
  end
  get 'callbacks', to: 'services#callbacks'
  get 'disconnect_vk', to: 'services#disconnect_vk'
  resources :senders
  resources :users
  get 'senders_delete', to: 'delete_senders#senders_delete'
  post 'invite_link', to: 'senders#invite_link'
  resources :messages
end
