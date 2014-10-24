module ApplicationHelper
  def active(page)
    current_page?(page) ? 'active' : ''
  end

  def route_specific_javascript
    file = "#{controller_name}/#{action_name}"
    unless Dir["app/assets/javascripts/#{file}.js.coffee"].empty?
      javascript_include_tag "#{file}"
    end
  end
end
