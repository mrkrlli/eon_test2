Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root "pages#show", page: "home"

  authenticate :user do
    get "/purchase", to: "purchase#subscribe", as: "purchase"
    post "/purchase", to: "purchase#process_subscription", as: "purchase_process"
    get "/purchase_success", to: "purchase#subscription_success", as: "purchase_success"
  end

  post "/process_stripe_webhook",
    to: "purchase#process_stripe_webhook",
    as: "process_stripe_webhook"
end
