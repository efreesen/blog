require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blog
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join("business")
    config.active_record.raise_in_transactional_callbacks = true
    config.exceptions_app = self.routes
  end
end
