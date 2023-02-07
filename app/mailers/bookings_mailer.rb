# frozen_string_literal: true

# rqrcode is a gem used to generate qr codes
require 'rqrcode'

#  Bookings mailer
class BookingsMailer < ApplicationMailer
  def booking_confirmation(booking) # rubocop:disable Metrics/MethodLength
    # Generate QRcode for the booking (to be included in the confirmation email)

    qrcode = RQRCode::QRCode.new(booking_root_url(booking.id))

    # The QR code will be in the svg format
    @svg = qrcode.as_svg(
      color: '000',
      shape_rendering: 'crispEdges',
      module_size: 11,
      standalone: true,
      use_path: true
    )
    # ----------------------------------------------
    #  Prepare the confirmation email
    @booking = booking
    @customer = booking.customer
    @seminar = booking.seminar
    mail to: @customer.email_address, subject: "Booking confirmation for #{@seminar.name}"
  end

  private

  def booking_root_url(booking_id)
    if Rails.env.development?
      "http://localhost:3000/bookings/#{booking_id}/booking_details"
    end
    # TODO: - Prepare the Production environment url
  end
end
