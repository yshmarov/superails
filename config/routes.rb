Rails.application.routes.draw do
  devise_for :users, 
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                   confirmations: 'users/confirmations',
                   registrations: 'users/registrations'
                 }
  root 'static_public#landing_page'
  get 'privacy', to: 'static_public#privacy'
  get 'terms', to: 'static_public#terms'
  get 'pricing', to: 'static_public#pricing'
  get 'about', to: 'static_public#about'

  resources :comments, only: [] do
    resources :comments, only: %i[new create destroy], module: :comments
  end

  resources :posts do
    resources :comments, only: %i[new create destroy], module: :posts
    member do
      patch "upvote", to: "posts#upvote"
      patch "downvote", to: "posts#downvote"
    end
  end

  post "checkout/create", to: "checkout#create", as: "checkout_create"
  post "billing_portal/create", to: "billing_portal#create", as: "billing_portal_create"
  resources :webhooks, only: [:create]

  resources :users, only: %i[index show]

end
