# frozen_string_literal: true

# Helper methods for Rails views
module ApplicationHelper
  require 'action_view'
  include ActionView::Helpers::NumberHelper

  def avatar_for_name(name, options = { size: '300x300' })
    hash = Digest::MD5.hexdigest(name)
    size = options[:size]
    robot_url = "https://robohash.org/#{hash}.png/bgset_any?size=#{size}"
    image_tag(robot_url, alt: name, class: 'rounded-circle shadow')
  end

  def to_dollars(amount)
    number_to_currency(amount, precision: 0, unit: '$')
  end
end
