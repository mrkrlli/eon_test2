require 'date'

class PurchaseController < ApplicationController
  def subscribe

  end

  def subscription_success

  end

  def process_subscription
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']

    customer = Stripe::Customer.create(
      :source => params[:stripeToken], # obtained from Stripe.js
      :plan => "test_plan",
      :email => params[:stripeEmail]
    )

    current_user.update_attributes(stripe_customer_id: customer.id,
                                   subscription: true,
                                   active_until: Date.today + 1.month)

    redirect_to purchase_success_path
  end

  def process_stripe_webhook
    head :ok
  end
end
