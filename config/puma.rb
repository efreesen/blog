#!/usr/bin/env puma

workers 2
threads 0, 16

preload_app!

rackup      DefaultRackup
environment ENV['RAILS_ENV'] || 'production'

daemonize true

pidfile "/var/run/efreesen/puma.pid"
stdout_redirect "/var/log/puma/stdout.log", "/var/log/puma/stderr.log"

threads 0, 16

bind "/var/run/puma/puma.sock"

on_worker_boot do
  ActiveRecord::Base.establish_connection
end
