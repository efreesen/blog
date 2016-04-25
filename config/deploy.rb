require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/puma'
# require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
# require 'mina/rvm'    # for rvm support. (http://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :domain, '104.233.115.225'
set :deploy_to, '/var/www/blog'
set :ssh_options, '-o IdentitiesOnly=yes'
set :identity_file, '/Users/caiotorres/.ssh/deploy_key'
set :repository, 'git@code.efreesen.com:efreesen/blog.git'
set :branch, 'master'
set :puma_pid, "/var/run/efreesen/puma.pid"

# For system-wide RVM install.
#   set :rvm_path, '/usr/local/rvm/bin/rvm'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'config/secrets.yml', 'config/unicorn.rb']
set :keep_releases,   3

# Optional settings:
set :user, 'deploy'
set :bundle_options, lambda { %{--without development:test --path "#{bundle_path}" --binstubs --deployment} }
#   set :port, '30000'     # SSH port number.
#   set :forward_agent, true

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue! %[touch "#{deploy_to}/#{shared_path}/config/unicorn.rb"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml' and unicorn.rb."]

  queue %[
    repo_host=`echo $repo | sed -e 's/.*@//g' -e 's/:.*//g'` &&
    repo_port=`echo $repo | grep -o ':[0-9]*' | sed -e 's/://g'` &&
    if [ -z "${repo_port}" ]; then repo_port=22; fi &&
    ssh-keyscan -p 22 -H code.efreesen.com >> ~/.ssh/known_hosts
  ]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  to :before_hook do
    # Put things to run locally before ssh
  end
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.

    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    queue 'RAILS_ENV=production bin/rake sitemap:generate'
    queue 'cp public/sitemaps/sitemap.xml public/sitemap.xml'
    queue 'RAILS_ENV=production bin/rake tmp:cache:clear'
    invoke :'deploy:cleanup'

    to :launch do
      if File.exists?("/var/run/efreesen/puma.pid")
        invoke :'puma:phased_restart'
      else
        invoke :'puma:start'
      end
    end
  end
end
