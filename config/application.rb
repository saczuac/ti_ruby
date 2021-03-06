require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
# require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TiRuby
  class Application < Rails::Application
  	config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
  	TiRuby::Application.config.session_store :cookie_store, key: 'lists'
  	config.i18n.default_locale = :'es-AR'
  	config.time_zone = 'Buenos Aires'
  	config.serve_static_assets = true
  	config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'
  	config.assets.compile = true
  	config.assets.digest = true
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
