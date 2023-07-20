Rails.application.routes.draw do
  devise_for :users, path: 'auth', controllers: {
    sessions: 'auth/sessions',
    registrations: 'auth/registrations'
  }, skip: [:sessions]

  devise_scope :user do
    post '/auth/sign_in', to: 'auth/sessions#create'
    delete '/auth/sign_out', to: 'auth/sessions#destroy'
  end

  namespace :api do
    namespace :v1 do
      post 'sign_in', to: 'auth/sessions#create'
      resources :registrations, only: [:create]
    end
  end
end