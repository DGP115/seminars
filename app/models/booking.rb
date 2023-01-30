# frozen_string_literal: true

# Model for Bookings
class Booking < ApplicationRecord
  belongs_to :customer
  belongs_to :seminar

  after_create :update_seminar_remaining_seats

  private

  def update_seminar_remaining_seats
    seminar.update(remaining_seats: seminar.total_seats - ticket_qty)
  end
end
