OmniAuth.config.full_host = "http://localhost:3000"

Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  # provider :google, ENV["GOOGLE_DOMAIN"], ENV["GOOGLE_SECRET"], scope: "https://docs.google.com/feed"
end
