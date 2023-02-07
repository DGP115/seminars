# frozen_string_literal: true

# Bookings controller
class BookingsController < ApplicationController
  def create # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    @stripe_service = StripeService.new
    # Recall that seminar_id is a hidden field on the form.  There, is set equal to @seminar.id
    @seminar = Seminar.find(params[:seminar_id])

    set_customer_objects

    # Create the charge in stripe
    @card = @stripe_service.create_stripe_customer_card(card_token_params, @stripe_customer)

    @amount_to_be_paid = ticket_qty * @seminar.registration_fee

    @charge = @stripe_service.create_stripe_charge(@amount_to_be_paid,
                                                   @stripe_customer.id,
                                                   @card.id,
                                                   @seminar)

    @booking = @seminar.bookings.create(customer_id: @customer.id,
                                        seminar_id: @seminar.id,
                                        stripe_transaction_id: @charge.id,
                                        ticket_qty: ticket_qty, # rubocop:disable Style/HashSyntax
                                        amount_paid: @amount_to_be_paid)

    BookingsMailer.booking_confirmation(@booking).deliver_now

    redirect_to seminar_path(@seminar), notice: "#{ticket_qty} tickets have been booked"
  rescue Stripe::StripeError => e
    redirect_to seminar_path(@seminar), alert: e.message.to_s
  end

  def booking_details
    @booking = Booking.find(params[:id])
  end

  private

  def customer_params
    params.permit(:full_name, :contact_number, :email_address)
  end

  def card_token_params
    params.permit(:card_number, :exp_month, :exp_year, :cvv)
  end

  def set_customer_objects
    # Create customer
    # 1.  First, see if the customer already exists, using email_address as the identifier
    @customer = Customer.find_by(email_address: params[:email_address])

    # 2.  If the above does not find an existing customer, create a new one
    @customer = Customer.create(customer_params) unless @customer.present?

    # 3.  Find or create a corresponding stripe customer object for our app customer object
    @stripe_customer = @stripe_service.find_or_create_customer(@customer)
  end

  def ticket_qty
    params[:ticket_qty].to_i
  end
end
