# frozen_string_literal: true

# Helper methods for Rails views
module ApplicationHelper
  def avatar_for_name(name, options = { size: '300x300' })
    hash = Digest::MD5.hexdigest(name)
    size = options[:size]
    robot_url = "https://robohash.org/#{hash}.png/bgset_any?size=#{size}"
    image_tag(robot_url, alt: name, class: 'rounded-circle shadow')
  end
end
