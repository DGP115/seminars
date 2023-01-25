# frozen_string_literal: true

# Model for Seminars
class Seminar < ApplicationRecord
  validates :name, :description, presence: true
  validates :start_date, :end_date, :start_time, :end_time, presence: true
  validates :total_seats, :registration_fee, numericality: true, presence: true
  validates :end_date, comparison: { greater_than: :start_date,
                                     message: 'must be after Start Date' }
end
