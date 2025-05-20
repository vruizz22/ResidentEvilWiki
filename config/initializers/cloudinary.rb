# config/initializers/cloudinary.rb
Cloudinary.config do |config|
    config.cloud_name = Rails.application.credentials.dig(:cloudinary, :cloud_name)   # tu cloud_name :contentReference[oaicite:0]{index=0}
    config.api_key    = Rails.application.credentials.dig(:cloudinary, :api_key)     # tu api_key :contentReference[oaicite:1]{index=1}
    config.api_secret = Rails.application.credentials.dig(:cloudinary, :api_secret)  # tu api_secret :contentReference[oaicite:2]{index=2}
    config.secure     = true                                                         # usar HTTPS :contentReference[oaicite:3]{index=3}
    config.cdn_subdomain = true                                                      # opcional, subdominios CDN :contentReference[oaicite:4]{index=4}
  end
  