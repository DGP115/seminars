# frozen_string_literal: true

# Model for Customers
class Customer < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :seminars, through: :bookings

  validates :full_name, :contact_number, :stripe_customer_id, presence: true
  validates :email_address, presence: true, uniqueness: true
end
