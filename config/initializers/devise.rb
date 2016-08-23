Devise.setup do |config|
  config.mailer_sender = 'noreply@facebook_clone.com'
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 11
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.secret_key = '65414aca3a4bb4d663cbd47178a83c89d817a906313369a6a459b0f5e767de4b3dc9d01fddf460068ad30550019ede8953b20510582f711435381403dd3d844d'

  if Rails.env.development?
    config.omniauth :twitter, ENV["TWITTER_ID_DEVELOPMENT"], ENV["TWITTER_SECRET_DEVELOPMENT"]
    config.omniauth :facebook, ENV["FACEBOOK_ID_DEVELOPMENT"], ENV["FACEBOOK_SECRET_DEVELOPMENT"],
    scope: 'email', display: 'popup', info_fields: 'name, email'
  end
end
