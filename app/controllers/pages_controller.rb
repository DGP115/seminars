# frozen_string_literal: true

# Controller for static pages
class PagesController < ApplicationController
  def home; end

  def about; end

  def calendar
    @seminars = Seminar.all
  end
end
