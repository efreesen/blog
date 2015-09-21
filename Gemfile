source 'https://rubygems.org'

ruby '2.2.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.2'
# Use mysql2 as the database for Active Record
gem 'mysql2', '~> 0.3.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3'
gem 'therubyracer', '~> 0.12'
gem 'less-rails-bootstrap', '~> 3.3'
gem 'entity_rb', '~> 0'
gem 'actionpack-action_caching', '~> 1.1'
gem 'yui-compressor', '~> 0.12'
gem 'rollbar', '~>  2.2.1'
gem 'mina', '~> 0.3'
gem 'mina-unicorn', '~>  0.3', require: false
gem "dynamic_sitemaps", '~> 2.0.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry-meta', '~> 0'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.1'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 1.3'

  gem 'rspec', '~> 3.2'
end

group :production do
  gem 'unicorn', '~> 4.8'
end
