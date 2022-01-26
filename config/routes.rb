Rails.application.routes.draw do
  devise_for :users
  root to: 'chats#index'
  
  get "/manifest.json", to: "service_workers#manifest"
  get "/service-worker.js"  => "service_workers#service_worker"
  get "/integrantes"  => "home#integrantes", as: 'integrantes'

  resources :contacts, only: %i(index new create destroy)
  resources :chats, only: %i(index show) do
    resources :messages, only: :create, default: { format: :js }
  end

end
