# frozen_string_literal: true

#  Mailer base class
class ApplicationMailer < ActionMailer::Base
  # --- To access view helpers from mailers
  include ApplicationHelper
  helper :application
  # --------------------------------------
  default from: 'no-reply@someguy.com'
  layout 'mailer'
end
