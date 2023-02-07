# frozen_string_literal: true

# Model for Seminars
class Seminar < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :customers, through: :bookings

  validates :name, :description, presence: true
  validates :start_date, :end_date, :start_time, :end_time, presence: true
  validates :total_seats, :registration_fee, numericality: true, presence: true
  validates :end_date, comparison: { greater_than: :start_date,
                                     message: 'must be after Start Date' }

  extend FriendlyId
  friendly_id :name, use: :slugged

  scope :upcoming_seminars, -> { where('start_date > ?', Date.today) }
  scope :past_seminars, -> { where('end_date < ?', Date.today) }

  def duration_expression
    " #{start_date.strftime('%b-%d-%Y')} to #{end_date.strftime('%b-%d-%Y')}"
  end

  def daily_duration
    ((end_time.to_time - start_time.to_time) / 1.hours).abs
  end

  def daily_hours_expression
    " #{start_time} to #{end_time}, (#{daily_duration} hours)"
  end

  def underway?
    start_date <= Date.today && end_date > Date.today
  end

  def over?
    end_date < Date.today
  end

  def upcoming?
    start_date > Date.today
  end
end
