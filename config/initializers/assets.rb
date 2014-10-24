Rails.application.config.assets.precompile += Dir["app/assets/javascripts/*/*"].map do |filename|
  filename.gsub %r(^app/assets/javascripts/|.coffee$), ''
end
