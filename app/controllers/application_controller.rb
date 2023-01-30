# frozen_string_literal: true

# Base class for app-specific controllers
class ApplicationController < ActionController::Base
  before_action :config_simple_calendar

  private

  #  Global settings for simple_calendar gem

  def config_simple_calendar
    Date.beginning_of_week = :sunday
    config.time_zone = 'Eastern Time (US & Canada)'
  end
end
