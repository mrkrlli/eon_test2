Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root "pages#show", page: "home"

  authenticate :user do
    get "/purchase", to: "purchase#subscribe", as: "purchase"
  end
end
