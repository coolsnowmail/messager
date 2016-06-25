VkontakteApi.configure do |config|
  # Authorization parameters (not needed when using an external authorization):
  config.app_id       = '5541120'
  config.app_secret   = 'Q47rrngS4wGs89ArXzOa'
  config.redirect_uri = 'http://localhost:3000/callbacks'

  # Faraday adapter to make requests with:
  # config.adapter = :net_http

  # HTTP verb for API methods (:get or :post)
  # config.http_verb = :get

  # Logging parameters:
  # log everything through the rails logger
  # config.logger = Rails.logger

  # log requests' URLs
  # config.log_requests = true

  # log response JSON after errors
  # config.log_errors = true

  # log response JSON after successful responses
  # config.log_responses = false
end

# create a short alias VK for VkontakteApi module
# VkontakteApi.register_alias
# https://oauth.vk.com/authorize?client_id=5537227&display=page&redirect_uri=https://shielded-stream-25949.herokuapp.com/services/callbacks&scope=message&response_type=code&v=5.52
