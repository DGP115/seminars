# frozen_string_literal: true

require 'stripe'

# This class defines the service provide by the Stripe gem [for payment processing)]
class StripeService
  def initialize
    Stripe.api_key = Rails.application.credentials.dig(:STRIPE, :SECRET_KEY)
  end

  def find_or_create_customer(customer)
    #  If our customer object has a defined stripe_customer_id, retrieve the corresponding
    #  stripe customer object from stripe
    stripe_customer = if customer.stripe_customer_id.present?
                        Stripe::Customer.retrieve(customer.stripe_customer_id)
                      #  else, create a stripe customer object using attributes of our app object
                      else
                        Stripe::Customer.create({ name: customer.full_name,
                                                  email: customer.email_address,
                                                  phone: customer.contact_number })
                      end
    # For the customer object in our app, set the stripe_customer_id attribute
    customer.update(stripe_customer_id: stripe_customer.id)

    # return the stripe customer object
    stripe_customer
  end

  def create_card_token(params)
    Stripe::Token.create({
                           card: {
                             number: params[:card_number].to_s,
                             exp_month: params[:exp_month],
                             exp_year: params[:exp_year],
                             cvc: params[:cvv]
                           }
                         })
  end

  def create_stripe_customer_card(params, stripe_customer)
    token = create_card_token(params)
    Stripe::Customer.create_source(stripe_customer.id, { source: token.id })
  end

  def create_stripe_charge(amount_to_be_paid, stripe_customer_id, card_id, seminar)
    # NOTE:  Stripe accepts payment amounts in cents
    Stripe::Charge.create({
                            amount: amount_to_be_paid * 100,
                            currency: 'CAD',
                            source: card_id,
                            customer: stripe_customer_id,
                            description: "Amount $#{amount_to_be_paid} charged for
                                          tickets to seminar: #{seminar.name}"
                          })
  end
end
