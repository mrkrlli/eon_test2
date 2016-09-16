class PurchaseController < ApplicationController
  def subscribe

  end

  def subscription_success

  end

  def process_subscription
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']

    Stripe::Customer.create(
      :source => params[:stripeToken], # obtained from Stripe.js
      :plan => "test_plan",
      :email => params[:stripeEmail]
    )

    redirect_to purchase_success_path
  end
end
