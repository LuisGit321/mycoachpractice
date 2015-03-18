Mycoachpractice::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  authenticated :user do
    root :to => 'home#index'
  end

  root :to => "home#index"

  devise_for :users

  resources :users, :only => [ :show, :index ]
  resources :proposals
  resources :leads do
    resources :proposals, :only => [ :new ]
  end
  match "students/provider_confirmation/:provider_confirmation_token" => "users/students#provider_confirmation", as: :provider_confirmation, via: :get
end
